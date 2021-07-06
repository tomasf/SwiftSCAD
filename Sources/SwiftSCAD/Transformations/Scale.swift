//
//  Translate.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Scale3D: Geometry3D {
	let scale: Vector3D
	let body: Geometry3D

	func scadString(environment: Environment) -> String {
		return SCADCall(
			name: "scale",
			params: ["v": scale],
			body: body
		)
		.scadString(environment: environment)
	}
}

public extension Geometry3D {
	func scale(_ scale: Vector3D) -> Geometry3D {
		Scale3D(scale: scale, body: self)
	}

	func scale(_ factor: Double) -> Geometry3D {
		Scale3D(scale: [factor, factor, factor], body: self)
	}

	func scale(x: Double = 1, y: Double = 1, z: Double = 1) -> Geometry3D {
		Scale3D(scale: [x, y, z], body: self)
	}
}


struct Scale2D: Geometry2D {
	let scale: Vector2D
	let body: Geometry2D

	func scadString(environment: Environment) -> String {
		return SCADCall(
			name: "scale",
			params: ["v": scale],
			body: body
		)
		.scadString(environment: environment)
	}
}

public extension Geometry2D {
	func scale(_ scale: Vector2D) -> Geometry2D {
		Scale2D(scale: scale, body: self)
	}

	func scale(_ factor: Double) -> Geometry2D {
		Scale2D(scale: [factor, factor], body: self)
	}

	func scale(x: Double = 1, y: Double = 1) -> Geometry2D {
		Scale2D(scale: [x, y], body: self)
	}
}
