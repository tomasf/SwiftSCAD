//
//  Arc.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Arc: Geometry2D {
	let angles: Range<Double>
	let radius: Double

	init(angles: Range<Double>, radius: Double) {
		self.angles = angles
		self.radius = radius
	}

	init(angles: Range<Double>, diameter: Double) {
		self.init(angles: angles, radius: diameter / 2)
	}

	func generateOutput(environment: Environment) -> String {
		let magnitude = angles.upperBound - angles.lowerBound
		let fraction = magnitude / 360.0

		let circleFacets: Double

		switch environment.facets {
		case .fixed (let perRev):
			circleFacets = Double(perRev)

		case .dynamic (let minAngle, let minSize):
			let facetsFromAngle = 360.0 / minAngle
			let circumference = radius * 2 * .pi
			let facetsFromSize = circumference / minSize
			circleFacets = min(facetsFromAngle, facetsFromSize)
		}

		let facetCount = max(Int(ceil(circleFacets * fraction)), 2)
		let facetAngle = magnitude / Double(facetCount)

		let outerPoints = (0...facetCount).map { i -> Vector2D in
			let angle = (angles.lowerBound + facetAngle * Double(i)) / (180.0 / .pi)
			return Vector2D(x: cos(angle) * radius, y: sin(angle) * radius)
		}
		let allPoints = [Vector2D.zero] + outerPoints + [Vector2D.zero]
		return Polygon(allPoints).generateOutput(environment: environment)
	}
}
