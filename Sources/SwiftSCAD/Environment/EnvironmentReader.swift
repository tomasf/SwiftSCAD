import Foundation

internal struct EnvironmentReader2D: Geometry2D {
    let body: (Environment) -> Geometry2D

    func scadString(in environment: Environment) -> String {
        body(environment).scadString(in: environment)
    }
}

internal struct EnvironmentReader3D: Geometry3D {
    let body: (Environment) -> Geometry3D

    func scadString(in environment: Environment) -> String {
        body(environment).scadString(in: environment)
    }
}

internal func EnvironmentReader(@UnionBuilder2D body: @escaping (Environment) -> Geometry2D) -> Geometry2D {
    EnvironmentReader2D(body: body)
}

internal func EnvironmentReader(@UnionBuilder3D body: @escaping (Environment) -> Geometry3D) -> Geometry3D {
    EnvironmentReader3D(body: body)
}

public extension Geometry2D {
    func readingEnvironment(@UnionBuilder2D _ body: @escaping (Environment) -> Geometry2D) -> Geometry2D {
        EnvironmentReader2D(body: body)
    }
}

public extension Geometry3D {
    func readingEnvironment(@UnionBuilder3D _ body: @escaping (Environment) -> Geometry3D) -> Geometry3D {
        EnvironmentReader3D(body: body)
    }
}
