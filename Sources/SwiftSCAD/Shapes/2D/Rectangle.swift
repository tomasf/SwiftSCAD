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

	public func scadString(environment: Environment) -> String {
		let square = SCADCall(name: "square", params: ["size": size], body: nil)
		guard !center.isEmpty else {
			return square.scadString(environment: environment)
		}

		let translation = (size / -2).replace(axes: center.inverted, with: 0)
		return SCADCall(name: "translate", params: ["v": translation], body: square)
			.scadString(environment: environment)
	}
}
