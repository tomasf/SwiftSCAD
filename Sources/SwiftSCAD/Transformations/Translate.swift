//
//  Translate.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Translate3D: Geometry3D {
	let distance: Vector3D
	let body: Geometry3D

	init(_ distance: Vector3D, @UnionBuilder _ body: () -> Geometry3D) {
		self.distance = distance
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		return "translate(\(distance.scadString)) \(body.generateOutput(environment: environment))"
	}
}

func Translate(_ distance: Vector3D, @UnionBuilder _ body: () -> Geometry3D) -> Translate3D {
	Translate3D(distance, body)
}

func Translate(x: Double = 0, y: Double = 0, z: Double = 0, @UnionBuilder _ body: () -> Geometry3D) -> Translate3D {
	Translate3D(Vector3D(x: x, y: y, z: z), body)
}

extension Geometry3D {
	func translate(_ distance: Vector3D) -> Geometry3D {
		Translate3D(distance) { self }
	}

	func translate(x: Double = 0, y: Double = 0, z: Double = 0) -> Geometry3D {
		Translate3D(Vector3D(x: x, y: y, z: z)) { self }
	}
}


struct Translate2D: Geometry2D {
	let distance: Vector2D
	let body: Geometry2D

	init(_ distance: Vector2D, @UnionBuilder _ body: () -> Geometry2D) {
		self.distance = distance
		self.body = body()
	}

	init(x: Double = 0, y: Double = 0, @UnionBuilder _ body: () -> Geometry2D) {
		self.init(Vector2D(x: x, y: y), body)
	}

	func generateOutput(environment: Environment) -> String {
		return "translate(\(distance.scadString)) \(body.generateOutput(environment: environment))"
	}
}

func Translate(_ distance: Vector2D, @UnionBuilder _ body: () -> Geometry2D) -> Translate2D {
	Translate2D(distance, body)
}

func Translate(x: Double = 0, y: Double = 0, @UnionBuilder _ body: () -> Geometry2D) -> Translate2D {
	Translate2D(Vector2D(x: x, y: y), body)
}

extension Geometry2D {
	func translate(_ distance: Vector2D) -> Geometry2D {
		Translate2D(distance) { self }
	}

	func translate(x: Double = 0, y: Double = 0) -> Geometry2D {
		Translate2D(Vector2D(x: x, y: y)) { self }
	}
}
