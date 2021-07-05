//
//  Polygon.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

public struct Polygon: Geometry2D {
	public let points: [Vector2D]

	public init(_ points: [Vector2D]) {
		self.points = points
	}

	public func scadString(environment: Environment) -> String {
		return "polygon([\(points.map(\.scadString).joined(separator: ","))]);"
	}
}
