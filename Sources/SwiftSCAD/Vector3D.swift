//
//  Vector3D.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Vector3D: ExpressibleByArrayLiteral {
	let x: Double
	let y: Double
	let z: Double

	static let zero = Vector3D(x: 0, y: 0, z: 0)

	init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}

	init(arrayLiteral: Double...) {
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


extension Vector3D {
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

	func replace(axes: Axes3D, with replacement: Double) -> Vector3D {
		Vector3D(
			x: axes.contains(.x) ? replacement : x,
			y: axes.contains(.y) ? replacement : y,
			z: axes.contains(.z) ? replacement : z
		)
	}
}
