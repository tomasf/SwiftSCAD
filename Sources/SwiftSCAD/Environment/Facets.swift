//
//  Modifiers.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

func facetModification(_ facets: Environment.Facets, body: Geometry, environment: Environment) -> String {
	let variables: [String: String]

	switch facets {
	case .fixed (let count):
		variables = ["fn": String(count)]
	case .dynamic (let minAngle, let minSize):
		variables = ["fa": minAngle.scadString, "fs": String(minSize), "fn": "0"]
	}

	let varString = variables.map { key, value in
		"$\(key) = \(value); "
	}.joined()

	let newEnvironment = environment.withFacets(facets)
	return "union() { \(varString) \(body.scadString(environment: newEnvironment)) }"
}


struct SetFacets3D: Geometry3D {
	let facets: Environment.Facets
	let body: Geometry3D

	func scadString(environment: Environment) -> String {
		facetModification(facets, body: body, environment: environment)
	}
}

public extension Geometry3D {
	func withFacets(minAngle: Angle, minSize: Double) -> Geometry3D {
		SetFacets3D(facets: .dynamic(minAngle: minAngle, minSize: minSize), body: self)
	}

	func withFacets(count: Int) -> Geometry3D {
		SetFacets3D(facets: .fixed(count), body: self)
	}
}


struct SetFacets2D: Geometry2D {
	let facets: Environment.Facets
	let body: Geometry2D

	func scadString(environment: Environment) -> String {
		facetModification(facets, body: body, environment: environment)
	}
}

public extension Geometry2D {
	func withFacets(minAngle: Angle, minSize: Double) -> Geometry2D {
		SetFacets2D(facets: .dynamic(minAngle: minAngle, minSize: minSize), body: self)
	}

	func withFacets(count: Int) -> Geometry2D {
		SetFacets2D(facets: .fixed(count), body: self)
	}
}