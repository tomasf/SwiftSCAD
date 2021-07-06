import Foundation

struct Minkowski3D: Geometry3D {
	let children: [Geometry3D]

	func scadString(environment: Environment) -> String {
		SCADCall(name: "minkowski", body: GeometrySequence(children: children))
			.scadString(environment: environment)
	}
}

public func MinkowskiSum(@SequenceBuilder components: () -> [Geometry3D]) -> Geometry3D {
	Minkowski3D(children: components())
}


struct Minkowski2D: Geometry2D {
	let children: [Geometry2D]

	func scadString(environment: Environment) -> String {
		SCADCall(name: "minkowski", body: GeometrySequence(children: children))
			.scadString(environment: environment)
	}
}

public func MinkowskiSum(@SequenceBuilder components: () -> [Geometry2D]) -> Geometry2D {
	Minkowski2D(children: components())
}
