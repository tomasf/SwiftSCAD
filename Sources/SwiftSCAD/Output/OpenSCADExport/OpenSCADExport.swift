import Foundation

struct OpenSCADExport {
    let inputCode: Data
    let outputFormat: any OutputFormat

    static let executableEnvironmentVariableName = "OPENSCAD"

    func run() throws -> Data {
        guard let formatString = outputFormat.openSCADTypeString else {
            preconditionFailure("Output format isn't valid for export")
        }

        guard let openSCAD = Self.executableURL() else {
            throw RunError.noExecutable
        }

        let inputPipe = Pipe()
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        let process = Process()
        process.executableURL = openSCAD
        process.arguments = [
            "-o", "-", // Write to stdout
            "--export-format", formatString,
            "--enable", "all", // Enable all "experimental" features, such as manifold
            "-" // Read from stdin
        ]
        process.standardInput = inputPipe
        process.standardOutput = outputPipe
        process.standardError = errorPipe

        try process.run()
        inputPipe.fileHandleForWriting.write(inputCode)
        try inputPipe.fileHandleForWriting.close()

        guard let data = try outputPipe.fileHandleForReading.readToEnd() else {
            throw RunError.noData
        }

        process.waitUntilExit()

        if process.terminationStatus != 0 {
            let errorData = try? errorPipe.fileHandleForReading.readToEnd()
            let errorString = errorData.flatMap { String(data: $0, encoding: .utf8) }
            throw RunError.processFailed(Int(process.terminationStatus), errorString ?? "")
        }

        if case OutputFormat3D.stlBinary = outputFormat {
            return data.fixBinarySTLIfNeeded()
        } else {
            return data
        }
    }

    static func executableURL() -> URL? {
        if let path = ProcessInfo.processInfo.environment[executableEnvironmentVariableName] {
            return URL(filePath: path)
        }

        return findExecutableAutomatically()
    }

    enum RunError: LocalizedError {
        case noExecutable
        case processFailed (Int, String)
        case noData

        var errorDescription: String? {
            switch self {
            case .noExecutable:
                "OpenSCAD was not found. Use the \(OpenSCADExport.executableEnvironmentVariableName) environment variable to set the path to the executable."
            case .processFailed (let code, let info):
                "Running OpenSCAD failed with code \(code): \(info)"
            case .noData:
                "Running OpenSCAD failed. No data was returned."
            }
        }
    }
}
