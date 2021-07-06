//
//  Extrude.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Extrude: Geometry3D {
	let body: Geometry2D
	let extrusion: Extrusion
	let convexity: Int

	init(_ extrusion: Extrusion, convexity: Int, body: Geometry2D) {
		self.body = body
		self.extrusion = extrusion
		self.convexity = convexity
	}

	func scadString(environment: Environment) -> String {
		let call: SCADCall

		switch extrusion {
		case .linear (let height):
			call = SCADCall(
				name: "linear_extrude",
				params: [
					"height": height,
					"convexity": convexity
				],
				body: body
			)

		case .rotational (let angle):
			call = SCADCall(
				name: "rotate_extrude",
				params: [
					"angle": angle,
					"convexity": convexity
				],
				body: body
			)
		}

		return call.scadString(environment: environment)
	}

	enum Extrusion {
		case linear (height: Double)
		case rotational (angle: Angle)
	}
}

public extension Geometry2D {
	func extrude(height: Double, convexity: Int = 2) -> Geometry3D {
		Extrude(.linear(height: height), convexity: convexity, body: self)
	}

	func extrude(angle: Angle, convexity: Int = 2) -> Geometry3D {
		Extrude(.rotational(angle: angle), convexity: convexity, body: self)
	}
}
