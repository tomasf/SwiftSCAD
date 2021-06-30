//
//  Rectangle.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Rectangle: Geometry2D {
	public let size: Vector2D
	public let center: Axes2D

	public init(_ size: Vector2D, center: Axes2D = []) {
		self.size = size
		self.center = center
	}

	public func generateOutput(environment: Environment) -> String {
		let squareExpression = "square(\(size.scadString));"
		guard !center.isEmpty else {
			return squareExpression
		}

		let translation = (size / -2).replace(axes: center.inverted, with: 0)
		return "translate(\(translation.scadString)) \(squareExpression)"
	}
}
