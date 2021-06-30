//
//  Environment.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

public struct Environment {
	public let facets: Facets

	public init(facets: Facets = .defaults) {
		self.facets = facets
	}

	public func withFacets(_ facets: Facets) -> Environment {
		return Environment(facets: facets)
	}

	public enum Facets {
		case fixed (Int)
		case dynamic (minAngle: Double, minSize: Double)

		public static let defaults = Facets.dynamic(minAngle: 12, minSize: 2) // According to OpenSCAD docs
	}
}
