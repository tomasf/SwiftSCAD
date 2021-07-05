//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-05.
//

import Foundation

public protocol SCADFormattable {
	func scadString(environment: Environment) -> String
}

public protocol SCADValue: SCADFormattable {
	var scadString: String { get }
}

public extension SCADValue {
	func scadString(environment: Environment) -> String {
		scadString
	}
}



extension Double: SCADValue {
	public var scadString: String {
		String(format: "%.06f", self)
	}
}

extension String: SCADValue {
	public var scadString: String {
		"\"" + self.replacingOccurrences(of: "\"", with: "\\\"") + "\""
	}
}

extension Array: SCADFormattable where Element: SCADValue {
	public func scadString(environment: Environment) -> String {
		scadString
	}
}

extension Array: SCADValue where Element: SCADValue {
	public var scadString: String {
		"[" + map(\.scadString).joined(separator: ", ")  + "]"
	}
}

// A OpenSCAD call to a function or module

struct SCADCall: SCADFormattable {
	let name: String
	let params: [String: SCADValue]
	let body: SCADFormattable?

	func scadString(environment: Environment) -> String {
		let paramText = params
			.sorted(by: { a, b in a.key < b.key })
			.map { key, value in "\(key)=\(value.scadString)"}.joined(separator: ", ")

		return "\(name)(\(paramText)) \(body?.scadString(environment: environment) ?? ";")"
	}
}
