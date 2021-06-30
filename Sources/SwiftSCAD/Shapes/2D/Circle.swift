//
//  Circle.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Circle: Geometry2D {
	let diameter: Double

	init(diameter: Double) {
		self.diameter = diameter
	}

	init(radius: Double) {
		self.diameter = radius * 2
	}

	func generateOutput(environment: Environment) -> String {
		return "circle(d = \(diameter));"
	}
}
