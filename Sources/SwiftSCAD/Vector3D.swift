//
//  Vector3D.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public struct Vector3D: ExpressibleByArrayLiteral {
	public let x: Double
	public let y: Double
	public let z: Double

	public static let zero = Vector3D(x: 0, y: 0, z: 0)

	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}

	public init(arrayLiteral: Double...) {
		precondition(arrayLiteral.count == 3, "Vector3D requires exactly three elements")
		self.init(x: arrayLiteral[0], y: arrayLiteral[1], z: arrayLiteral[2])
	}

	internal var scadString: String {
		let xString = String(format: "%.06f", x)
		let yString = String(format: "%.06f", y)
		let zString = String(format: "%.06f", z)

		return "[\(xString), \(yString), \(zString)]"
	}
}


public extension Vector3D {
	static func /(_ v: Vector3D, _ d: Double) -> Vector3D {
		return Vector3D(
			x: v.x / d,
			y: v.y / d,
			z: v.z / d
		)
	}

	static func *(_ v: Vector3D, _ d: Double) -> Vector3D {
		return Vector3D(
			x: v.x * d,
			y: v.y * d,
			z: v.z * d
		)
	}

	static prefix func -(_ v: Vector3D) -> Vector3D {
		return Vector3D(
			x: -v.x,
			y: -v.y,
			z: -v.z
		)
	}

	static func +(_ v1: Vector3D, _ v2: Vector3D) -> Vector3D {
		return Vector3D(
			x: v1.x + v2.x,
			y: v1.y + v2.y,
			z: v1.z + v2.z
		)
	}

	static func -(_ v1: Vector3D, _ v2: Vector3D) -> Vector3D {
		return Vector3D(
			x: v1.x - v2.x,
			y: v1.y - v2.y,
			z: v1.z - v2.z
		)
	}

	static func +(_ v: Vector3D, _ s: Double) -> Vector3D {
		return Vector3D(
			x: v.x + s,
			y: v.y + s,
			z: v.z + s
		)
	}

	static func -(_ v: Vector3D, _ s: Double) -> Vector3D {
		return Vector3D(
			x: v.x - s,
			y: v.y - s,
			z: v.z - s
		)
	}

	func replace(axes: Axes3D, with replacement: Double) -> Vector3D {
		Vector3D(
			x: axes.contains(.x) ? replacement : x,
			y: axes.contains(.y) ? replacement : y,
			z: axes.contains(.z) ? replacement : z
		)
	}

	var xy: Vector2D {
		Vector2D(x:x, y:y)
	}
}
