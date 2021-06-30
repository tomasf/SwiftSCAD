//
//  Rotate.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Rotate3D: Geometry3D {
	let angles: Vector3D
	let body: Geometry3D

	init(_ degrees: Vector3D, @UnionBuilder _ body: () -> Geometry3D) {
		self.angles = degrees
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		return "rotate(\(angles.scadString)) \(body.generateOutput(environment: environment))"
	}
}

public func Rotate(_ degrees: Vector3D, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Rotate3D(degrees, body)
}

public func Rotate(x: Double = 0, y: Double = 0, z: Double = 0, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Rotate3D(Vector3D(x: x, y: y, z: z), body)
}

public func Rotate(radians: Vector3D, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Rotate3D(radians * (180.0 / .pi), body)
}

public extension Geometry3D {
	func rotate(_ degrees: Vector3D) -> Geometry3D {
		Rotate3D(degrees, { self })
	}

	func rotate(x: Double = 0, y: Double = 0, z: Double = 0) -> Geometry3D {
		Rotate3D(Vector3D(x: x, y: y, z: z), { self })
	}

	func rotate(radians: Vector3D) -> Geometry3D {
		Rotate3D(radians * (180.0 / .pi), { self })
	}
}


struct Rotate2D: Geometry2D {
	let angle: Double
	let body: Geometry2D

	init(_ degrees: Double, @UnionBuilder _ body: () -> Geometry2D) {
		self.angle = degrees
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		return "rotate(\(angle)) \(body.generateOutput(environment: environment))"
	}
}

public func Rotate(_ degrees: Double, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Rotate2D(degrees, body)
}

public func Rotate(radians: Double, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Rotate2D(radians * (180.0 / .pi), body)
}

public extension Geometry2D {
	func rotate(_ degrees: Double) -> Geometry2D {
		Rotate2D(degrees, { self })
	}

	func rotate(radians: Double) -> Geometry2D {
		Rotate2D(radians * (180.0 / .pi), { self })
	}
}
