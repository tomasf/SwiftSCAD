//
//  Extrude.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Extrude: Geometry3D {
	let children: Geometry2D
	let extrusion: Extrusion

	public init(height: Double, @UnionBuilder _ body: () -> Geometry2D) {
		self.children = body()
		self.extrusion = .linear(height: height)
	}

	public init(angle: Double, @UnionBuilder _ body: () -> Geometry2D) {
		self.children = body()
		self.extrusion = .rotational(angle: angle)
	}

	public func generateOutput(environment: Environment) -> String {
		let body = children.generateOutput(environment: environment)
		let firstLine: String

		switch extrusion {
		case .linear (let height):
			firstLine = "linear_extrude(height = \(height))"
		case .rotational (let angle):
			firstLine = "rotate_extrude(angle = \(angle))"
		}

		return "\(firstLine) {\n\(body)\n}"
	}

	enum Extrusion {
		case linear (height: Double)
		case rotational (angle: Double)
	}
}

public extension Geometry2D {
	func extrude(height: Double) -> Extrude {
		Extrude(height: height, { self })
	}

	func extrude(angle: Double) -> Extrude {
		Extrude(angle: angle, { self })
	}
}
