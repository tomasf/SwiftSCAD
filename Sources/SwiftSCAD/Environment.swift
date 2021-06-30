//
//  Environment.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Environment {
	let facets: Facets

	init(facets: Facets = .defaults) {
		self.facets = facets
	}

	func withFacets(_ facets: Facets) -> Environment {
		return Environment(facets: facets)
	}

	enum Facets {
		case fixed (Int)
		case dynamic (minAngle: Double, minSize: Double)

		static let defaults = Facets.dynamic(minAngle: 12, minSize: 2) // According to OpenSCAD docs
	}
}
