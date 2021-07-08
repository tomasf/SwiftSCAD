import Foundation

public protocol Geometry: SCADFormattable {
	func scadString(environment: Environment) -> String
}

public protocol Geometry3D: Geometry {}
public protocol Geometry2D: Geometry {}


public struct Empty: Geometry3D, Geometry2D {
	public init() {}
	public func scadString(environment: Environment) -> String {
		""
	}
}

