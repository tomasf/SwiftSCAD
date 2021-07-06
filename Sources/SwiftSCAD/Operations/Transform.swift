//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-04.
//

import Foundation

public struct AffineTransform: SCADValue {
	public var values: [[Double]]

	public init(_ values: [[Double]]) {
		precondition(
			values.count == 4 && values.allSatisfy { $0.count == 4},
			"AffineTransform requires 16 (4x4) elements"
		)
		self.values = values
	}

	public var scadString: String {
		values.scadString
	}

	public static var identity: AffineTransform {
		AffineTransform([
			[1, 0, 0, 0],
			[0, 1, 0, 0],
			[0, 0, 1, 0],
			[0, 0, 0, 1]
		])
	}

	public subscript(_ row: Int, _ column: Int) -> Double {
		get {
			values[row][column]
		}
		set {
			values[row][column] = newValue
		}
	}

}

struct Transform: Geometry3D {
	let transform: AffineTransform
	let body: Geometry3D

	func scadString(environment: Environment) -> String {
		SCADCall(
			name: "multmatrix",
			params: ["m": transform],
			body: body
		)
		.scadString(environment: environment)
	}
}

public extension Geometry3D {
	func transform(_ transform: AffineTransform) -> Geometry3D {
		Transform(transform: transform, body: self)
	}

	func shear(_ axis: Axis3D, along otherAxis: Axis3D, factor: Double) -> Geometry3D {
		precondition(axis != otherAxis, "Shearing requires two distinct axes")

		let order: [Axis3D] = [.x, .y, .z]
		let row = order.firstIndex(of: axis)!
		let column = order.firstIndex(of: otherAxis)!

		var t = AffineTransform.identity
		t[row, column] = factor
		return transform(t)
	}
}
