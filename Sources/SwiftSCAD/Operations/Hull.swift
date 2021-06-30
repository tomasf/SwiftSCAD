//
//  Hull.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Hull3D: Geometry3D {
	let body: Geometry3D

	init(@UnionBuilder _ body: () -> Geometry3D) {
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		"hull() { \(body.generateOutput(environment: environment)) }"
	}
}

func Hull(@UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Hull3D(body)
}

extension Geometry3D {
	func hull() -> Geometry3D {
		Hull3D { self }
	}
}


struct Hull2D: Geometry2D {
	let body: Geometry2D

	init(@UnionBuilder _ body: () -> Geometry2D) {
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		"hull() { \(body.generateOutput(environment: environment)) }"
	}
}

func Hull(@UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Hull2D(body)
}

extension Geometry2D {
	func hull() -> Geometry2D {
		Hull2D { self }
	}
}
