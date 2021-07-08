import Foundation

public struct Sphere: Geometry3D {
	public let diameter: Double

	public init(diameter: Double) {
		self.diameter = diameter
	}

	public init(radius: Double) {
		self.diameter = radius * 2
	}

	public func scadString(environment: Environment) -> String {
		return SCADCall(name: "sphere", params: ["d": diameter])
			.scadString(environment: environment)
	}
}
