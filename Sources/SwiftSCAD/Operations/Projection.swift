//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-04.
//

import Foundation

struct Projection: Geometry2D {
	let mode: Mode
	let body: Geometry3D

	func generateOutput(environment: Environment) -> String {
		switch mode {
		case .whole:
			let child = body.generateOutput(environment: environment)
			return "projection() \(child)"

		case .slice (let z):
			let child = body
				.translate(z: -z)
				.generateOutput(environment: environment)
			return "projection(cut = true) \(child)"
		}
	}

	enum Mode {
		case whole
		case slice (z: Double)
	}
}

public extension Geometry3D {
	func projection() -> Geometry2D {
		Projection(mode: .whole, body: self)
	}

	func projection(slicingAtZ z: Double) -> Geometry2D {
		Projection(mode: .slice(z: z), body: self)
	}
}
