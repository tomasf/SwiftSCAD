//
//  Box.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Box: Geometry3D {
	public let size: Vector3D
	public let center: Axes3D

	public init(_ size: Vector3D, center: Axes3D = []) {
		self.size = size
		self.center = center
	}

	public func scadString(environment: Environment) -> String {
		let cubeExpression = "cube(\(size.scadString));"
		guard !center.isEmpty else {
			return cubeExpression
		}

		let translation = (size / -2).replace(axes: center.inverted, with: 0)
		return "translate(\(translation.scadString)) \(cubeExpression)"
	}
}
