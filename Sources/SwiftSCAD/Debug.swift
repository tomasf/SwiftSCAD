//
//  Debug.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Highlight3D: Geometry3D {
	let body: Geometry3D

	func generateOutput(environment: Environment) -> String {
		return "#" + body.generateOutput(environment: environment)
	}
}

struct Highlight2D: Geometry2D {
	let body: Geometry2D

	func generateOutput(environment: Environment) -> String {
		return "#" + body.generateOutput(environment: environment)
	}
}

prefix operator %

prefix func %(_ body: Geometry3D) -> Geometry3D {
	Highlight3D(body: body)
}

prefix func %(_ body: Geometry2D) -> Geometry2D {
	Highlight2D(body: body)
}

extension Geometry2D {
	func highlighted() -> Geometry2D {
		Highlight2D(body: self)
	}
}

extension Geometry3D {
	func highlighted() -> Geometry3D {
		Highlight3D(body: self)
	}
}
