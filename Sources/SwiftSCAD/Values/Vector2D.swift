//
//  Vector3D.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Vector2D: ExpressibleByArrayLiteral, SCADValue {
	public let x: Double
	public let y: Double

	public static let zero = Vector2D(x: 0, y: 0)

	public init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}

	public init(_ x: Double, _ y: Double) {
		self.init(x: x, y: y)
	}

	public init(arrayLiteral: Double...) {
		precondition(arrayLiteral.count == 2, "Vector2D requires exactly two elements")
		self.init(x: arrayLiteral[0], y: arrayLiteral[1])
	}

	public var scadString: String {
		[x, y].scadString
	}
}

public extension Vector2D {
	init(axis: Axis2D, value: Double) {
		let x = (axis == .x) ? value : 0
		let y = (axis == .y) ? value : 0
		self.init(x, y)
	}

	func setting(axes: Axes2D, to value: Double) -> Vector2D {
		Vector2D(
			x: axes.contains(.x) ? value : x,
			y: axes.contains(.y) ? value : y
		)
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
}

public extension Vector2D {
	func distance(to other: Vector2D) -> Double {
		sqrt(pow(x - other.x, 2) + pow(y - other.y, 2))
	}

	func angle(to other: Vector2D) -> Angle {
		Angle(radians: atan2(other.y - y, other.x - x))
	}

	func point(alongLineTo other: Vector2D, at fraction: Double) -> Vector2D {
		self + (other - self) * fraction
	}
}
