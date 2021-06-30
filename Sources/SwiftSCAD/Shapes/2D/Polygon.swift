//
//  Polygon.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Polygon: Geometry2D {
	let points: [Vector2D]

	init(_ points: [Vector2D]) {
		self.points = points
	}

	func generateOutput(environment: Environment) -> String {
		return "polygon([\(points.map(\.scadString).joined(separator: ","))]);"
	}
}
