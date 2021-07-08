import Foundation

public protocol Shape: Geometry3D {
	var body: Geometry3D { get }
}

public extension Shape {
	func scadString(environment: Environment) -> String {
		body.scadString(environment: environment)
	}
}


public protocol Shape2D: Geometry2D {
	var body: Geometry2D { get }
}

public extension Shape2D {
	func scadString(environment: Environment) -> String {
		body.scadString(environment: environment)
	}
}
