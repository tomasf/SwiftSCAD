//
//  Vector3D.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Vector2D: ExpressibleByArrayLiteral {
	public let x: Double
	public let y: Double

	public static let zero = Vector2D(x: 0, y: 0)

	public init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}

	public init(arrayLiteral: Double...) {
		precondition(arrayLiteral.count == 2, "Vector2D requires exactly two elements")
		self.init(x: arrayLiteral[0], y: arrayLiteral[1])
	}

	internal var scadString: String {
		let xString = String(format: "%.06f", x)
		let yString = String(format: "%.06f", y)
		return "[\(xString), \(yString)]"
	}
}


public extension Vector2D {
	static func /(_ v: Vector2D, _ d: Double) -> Vector2D {
		return Vector2D(
			x: v.x / d,
			y: v.y / d
		)
	}

	static func *(_ v: Vector2D, _ d: Double) -> Vector2D {
		return Vector2D(
			x: v.x * d,
			y: v.y * d
		)
	}

	static func *(_ v1: Vector2D, _ v2: Vector2D) -> Vector2D {
		return Vector2D(
			x: v1.x * v2.x,
			y: v1.y * v2.y
		)
	}

	static func +(_ v1: Vector2D, _ v2: Vector2D) -> Vector2D {
		return Vector2D(
			x: v1.x + v2.x,
			y: v1.y + v2.y
		)
	}

	static func -(_ v1: Vector2D, _ v2: Vector2D) -> Vector2D {
		return Vector2D(
			x: v1.x - v2.x,
			y: v1.y - v2.y
		)
	}

	static prefix func -(_ v: Vector2D) -> Vector2D {
		return Vector2D(
			x: -v.x,
			y: -v.y
		)
	}


	static func +(_ v: Vector2D, _ s: Double) -> Vector2D {
		return Vector2D(
			x: v.x + s,
			y: v.y + s
		)
	}

	static func -(_ v: Vector2D, _ s: Double) -> Vector2D {
		return Vector2D(
			x: v.x - s,
			y: v.y - s
		)
	}

	func replace(axes: Axes2D, with replacement: Double) -> Vector2D {
		Vector2D(
			x: axes.contains(.x) ? replacement : x,
			y: axes.contains(.y) ? replacement : y
		)
	}
}

struct LineSegment {
	let p1: Vector2D
	let p2: Vector2D

	func point(at fraction: Double) -> Vector2D {
		p1 + (p2 - p1) * fraction
	}

	var length: Double {
		sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2))
	}
}
