//
//  Circle.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Circle: Geometry2D {
	public let diameter: Double

	public init(diameter: Double) {
		self.diameter = diameter
	}

	public init(radius: Double) {
		self.diameter = radius * 2
	}

	public func scadString(environment: Environment) -> String {
		return "circle(d = \(diameter));"
	}
}
