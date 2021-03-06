import Foundation

struct Scale3D: CoreGeometry3D {
	let scale: Vector3D
	let body: Geometry3D

	func call(in environment: Environment) -> SCADCall {
		SCADCall(
			name: "scale",
			params: ["v": scale],
			body: body
		)
	}

	var bodyTransform: AffineTransform {
		.scaling(scale)
	}
}

public extension Geometry3D {
	func scaled(_ scale: Vector3D) -> Geometry3D {
		Scale3D(scale: scale, body: self)
	}

	func scaled(_ factor: Double) -> Geometry3D {
		Scale3D(scale: [factor, factor, factor], body: self)
	}

	func scaled(x: Double = 1, y: Double = 1, z: Double = 1) -> Geometry3D {
		Scale3D(scale: [x, y, z], body: self)
	}
    
    func flipped(along axis: Axis3D) -> Geometry3D {
        Scale3D(scale: Vector3D(axis: axis, value: -1, default: 1), body: self)
    }
}


struct Scale2D: CoreGeometry2D {
	let scale: Vector2D
	let body: Geometry2D

	func call(in environment: Environment) -> SCADCall {
		SCADCall(
			name: "scale",
			params: ["v": scale],
			body: body
		)
	}

	var bodyTransform: AffineTransform {
		.scaling(x: scale.x, y: scale.y, z: 1)
	}
}

public extension Geometry2D {
	func scaled(_ scale: Vector2D) -> Geometry2D {
		Scale2D(scale: scale, body: self)
	}

	func scaled(_ factor: Double) -> Geometry2D {
		Scale2D(scale: [factor, factor], body: self)
	}

	func scaled(x: Double = 1, y: Double = 1) -> Geometry2D {
		Scale2D(scale: [x, y], body: self)
	}
    
    func flipped(along axis: Axis2D) -> Geometry2D {
        Scale2D(scale: Vector2D(axis: axis, value: -1, default: 1), body: self)
    }
}
