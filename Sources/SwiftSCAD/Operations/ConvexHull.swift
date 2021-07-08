import Foundation

struct ConvexHull3D: Geometry3D {
	let body: Geometry3D

	func scadString(environment: Environment) -> String {
		SCADCall(name: "hull", body: body)
			.scadString(environment: environment)
	}
}

public extension Geometry3D {
	func convexHull() -> Geometry3D {
		ConvexHull3D(body: self)
	}
}


struct ConvexHull2D: Geometry2D {
	let body: Geometry2D

	func scadString(environment: Environment) -> String {
		SCADCall(name: "hull", body: body)
			.scadString(environment: environment)
	}
}

public extension Geometry2D {
	func convexHull() -> Geometry2D {
		ConvexHull2D(body: self)
	}
}
