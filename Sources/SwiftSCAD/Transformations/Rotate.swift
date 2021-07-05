//
//  Rotate.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Rotate3D: Geometry3D {
	let x: Angle
	let y: Angle
	let z: Angle
	let body: Geometry3D

	init(x: Angle, y: Angle, z: Angle, @UnionBuilder _ body: () -> Geometry3D) {
		self.x = x
		self.y = y
		self.z = z
		self.body = body()
	}

	func scadString(environment: Environment) -> String {
		return "rotate([\(x.scadString), \(y.scadString), \(z.scadString)]) \(body.scadString(environment: environment))"
	}
}

public func Rotate(_ angles: [Angle], @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	precondition(angles.count == 3, "Rotate3D needs three angles")
	return Rotate3D(x: angles[0], y: angles[1], z: angles[2], body)
}

public func Rotate(x: Angle = 0, y: Angle = 0, z: Angle = 0, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Rotate3D(x: x, y: y, z: z, body)
}

public extension Geometry3D {
	func rotate(_ angles: [Angle]) -> Geometry3D {
		Rotate(angles, { self })
	}

	func rotate(x: Angle = 0, y: Angle = 0, z: Angle = 0) -> Geometry3D {
		Rotate3D(x: x, y: y, z: z, { self })
	}

	func rotate(angle: Angle, axis: Axis3D) -> Geometry3D {
		var angles = [0°, 0°, 0°]
		angles[axis.rawValue] = angle
		return rotate(angles)
	}
}


struct Rotate2D: Geometry2D {
	let angle: Angle
	let body: Geometry2D

	init(_ angle: Angle, @UnionBuilder _ body: () -> Geometry2D) {
		self.angle = angle
		self.body = body()
	}

	func scadString(environment: Environment) -> String {
		return "rotate(\(angle.scadString)) \(body.scadString(environment: environment))"
	}
}

public func Rotate(_ angle: Angle, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Rotate2D(angle, body)
}

public extension Geometry2D {
	func rotate(_ angle: Angle) -> Geometry2D {
		Rotate2D(angle, { self })
	}
}
