//
//  Extrude.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Extrude: Geometry3D {
	let children: Geometry2D
	let extrusion: Extrusion
	let convexity: Int

	public init(height: Double, convexity: Int = 2, @UnionBuilder _ body: () -> Geometry2D) {
		self.children = body()
		self.extrusion = .linear(height: height)
		self.convexity = convexity
	}

	public init(angle: Angle, convexity: Int = 2, @UnionBuilder _ body: () -> Geometry2D) {
		self.children = body()
		self.extrusion = .rotational(angle: angle)
		self.convexity = convexity
	}

	public func scadString(environment: Environment) -> String {
		let body = children.scadString(environment: environment)
		let firstLine: String

		switch extrusion {
		case .linear (let height):
			firstLine = "linear_extrude(height = \(height.scadString), convexity = \(convexity))"
		case .rotational (let angle):
			firstLine = "rotate_extrude(angle = \(angle.scadString), convexity = \(convexity))"
		}

		return "\(firstLine) {\n\(body)\n}"
	}

	enum Extrusion {
		case linear (height: Double)
		case rotational (angle: Angle)
	}
}

public extension Geometry2D {
	func extrude(height: Double, convexity: Int = 2) -> Geometry3D {
		Extrude(height: height, convexity: convexity, { self })
	}

	func extrude(angle: Angle, convexity: Int = 2) -> Geometry3D {
		Extrude(angle: angle, convexity: convexity, { self })
	}
}
