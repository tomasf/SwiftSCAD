//
//  RoundedRectangle.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct RoundedRectangle: Shape2D {
	let radii: CornerRadii
	let size: Vector2D

	init(_ size: Vector2D, cornerRadii: [Double]) {
		self.size = size
		self.radii = [cornerRadii[0], cornerRadii[1], cornerRadii[2], cornerRadii[3]]

		precondition(radii.bottomLeft + radii.bottomRight <= size.x)
		precondition(radii.topLeft + radii.topRight <= size.x)
		precondition(radii.topLeft + radii.bottomLeft <= size.y)
		precondition(radii.topRight + radii.bottomRight <= size.y)
	}

	init(_ size: Vector2D, cornerRadius: Double) {
		self.init(size, cornerRadii: [cornerRadius, cornerRadius, cornerRadius, cornerRadius])
	}

	init(_ size: Vector2D, bottomLeft: Double, bottomRight: Double, topRight: Double, topLeft: Double) {
		self.init(size, cornerRadii: [bottomLeft, bottomRight, topRight, topLeft])
	}

	@UnionBuilder var body: Geometry2D {
		Corner(angleOffset: 90, radius: radii.topLeft)
			.translate(x: radii.topLeft, y: size.y - radii.topLeft)

		Corner(angleOffset: 0, radius: radii.topRight)
			.translate(x: size.x - radii.topRight, y: size.y - radii.topRight)

		Corner(angleOffset: 180, radius: radii.bottomLeft)
			.translate(x: radii.bottomLeft, y: radii.bottomLeft)

		Corner(angleOffset: 270, radius: radii.bottomRight)
			.translate(x: size.x - radii.bottomRight, y: radii.bottomRight)

		Polygon([
			[radii.topLeft, size.y], [size.x - radii.topRight, size.y],
			[size.x, size.y - radii.topRight], [size.x, radii.bottomRight],
			[size.x - radii.bottomRight, 0], [radii.bottomLeft, 0],
			[0, radii.bottomLeft], [0, size.y - radii.topLeft]
		])
	}

	struct CornerRadii: ExpressibleByArrayLiteral {
		let bottomLeft: Double
		let bottomRight: Double
		let topRight: Double
		let topLeft: Double

		typealias ArrayLiteralElement = Double
		init(arrayLiteral elements: Double...) {
			precondition(elements.count == 4, "CornerRadii needs 4 radii")
			bottomLeft = elements[0]
			bottomRight = elements[1]
			topRight = elements[2]
			topLeft = elements[3]
		}
	}

	private struct Corner: Shape2D {
		let angleOffset: Double
		let radius: Double

		var body: Geometry2D {
			if radius > .ulpOfOne {
				return Arc(angles: 0..<90, radius: radius)
					.rotate(angleOffset)
			} else {
				return Rectangle([0.001, 0.001])
					.rotate(angleOffset + 180)
			}
		}
	}
}
