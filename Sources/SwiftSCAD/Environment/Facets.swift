//
//  Modifiers.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

public struct SetFacets: Geometry3D {
	public let facets: Environment.Facets
	let body: Geometry3D

	public func scadString(environment: Environment) -> String {
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
}

public extension Geometry3D {
	func withFacets(minAngle: Angle, minSize: Double) -> Geometry3D {
		SetFacets(facets: .dynamic(minAngle: minAngle, minSize: minSize), body: self)
	}

	func withFacets(count: Int) -> Geometry3D {
		SetFacets(facets: .fixed(count), body: self)
	}
}
