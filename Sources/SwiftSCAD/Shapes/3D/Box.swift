//
//  Box.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Box: Geometry3D {
	let size: Vector3D
	let center: Axes3D

	init(_ size: Vector3D, center: Axes3D = []) {
		self.size = size
		self.center = center
	}

	func generateOutput(environment: Environment) -> String {
		let cubeExpression = "cube(\(size.scadString));"
		guard !center.isEmpty else {
			return cubeExpression
		}

		let translation = (size / -2).replace(axes: center.inverted, with: 0)
		return "translate(\(translation.scadString)) \(cubeExpression)"
	}
}
