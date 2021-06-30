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

	init(_ scale: Vector3D, @UnionBuilder _ body: () -> Geometry3D) {
		self.scale = scale
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		return "scale(\(scale.scadString)) \(body.generateOutput(environment: environment))"
	}
}

public func Scale(_ scale: Vector3D, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Scale3D(scale, body)
}

public func Scale(x: Double = 1, y: Double = 1, z: Double = 1, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Scale3D(Vector3D(x: x, y: y, z: z), body)
}

public func Scale(_ factor: Double, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Scale3D(Vector3D(x: factor, y: factor, z: factor), body)
}

public extension Geometry3D {
	func scale(_ scale: Vector3D) -> Geometry3D {
		Scale3D(scale) { self }
	}

	func scale(_ factor: Double) -> Geometry3D {
		Scale3D(Vector3D(x: factor, y: factor, z: factor)) { self }
	}

	func scale(x: Double = 1, y: Double = 1, z: Double = 1) -> Geometry3D {
		Scale3D(Vector3D(x: x, y: y, z: z)) { self }
	}
}


struct Scale2D: Geometry2D {
	let scale: Vector2D
	let body: Geometry2D

	init(_ scale: Vector2D, @UnionBuilder _ body: () -> Geometry2D) {
		self.scale = scale
		self.body = body()
	}

	init(x: Double = 1, y: Double = 1, @UnionBuilder _ body: () -> Geometry2D) {
		self.init(Vector2D(x: x, y: y), body)
	}

	func generateOutput(environment: Environment) -> String {
		return "scale(\(scale.scadString)) \(body.generateOutput(environment: environment))"
	}
}

public func Scale(_ scale: Vector2D, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Scale2D(scale, body)
}

public func Scale(_ factor: Double, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Scale2D([factor, factor], body)
}

public func Scale(x: Double = 1, y: Double = 1, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Scale2D(Vector2D(x: x, y: y), body)
}

public extension Geometry2D {
	func scale(_ scale: Vector2D) -> Geometry2D {
		Scale2D(scale) { self }
	}

	func scale(_ factor: Double) -> Geometry2D {
		Scale2D([factor, factor]) { self }
	}

	func scale(x: Double = 1, y: Double = 1) -> Geometry2D {
		Scale2D(Vector2D(x: x, y: y)) { self }
	}
}
