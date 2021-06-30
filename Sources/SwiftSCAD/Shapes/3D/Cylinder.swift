//
//  Cylinder.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

public struct Cylinder: Geometry3D {
	public let height: Double
	public let diameter: Double
	public let topDiameter: Double?

	public init(diameter: Double, height: Double) {
		self.diameter = diameter
		self.topDiameter = nil
		self.height = height
	}

	public init(radius: Double, height: Double) {
		self.diameter = radius * 2
		self.topDiameter = nil
		self.height = height
	}

	public init(bottomDiameter: Double, topDiameter: Double, height: Double) {
		self.diameter = bottomDiameter
		self.topDiameter = topDiameter
		self.height = height
	}

	public func generateOutput(environment: Environment) -> String {
		if let topDiameter = topDiameter {
			return "cylinder(d1 = \(diameter), d2 = \(topDiameter), h = \(height));"
		} else {
			return "cylinder(d = \(diameter), h = \(height));"
		}
	}
}
