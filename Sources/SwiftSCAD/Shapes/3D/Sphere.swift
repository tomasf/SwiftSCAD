//
//  Sphere.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Sphere: Geometry3D {
	let diameter: Double

	init(diameter: Double) {
		self.diameter = diameter
	}

	init(radius: Double) {
		self.diameter = radius * 2
	}

	func generateOutput(environment: Environment) -> String {
		"sphere(d = \(diameter));"
	}
}
