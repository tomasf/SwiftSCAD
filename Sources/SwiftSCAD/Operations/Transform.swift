//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-04.
//

import Foundation

public struct AffineTransform {
	public var values: [[Double]]

	public init(_ values: [[Double]]) {
		precondition(
			values.count == 4 && values.allSatisfy { $0.count == 4},
			"AffineTransform requires 16 (4x4) elements"
		)
		self.values = values
	}

	var scadString: String {
		"[" + values.map { row in
			"[" + row
				.map(\.scadString)
				.joined(separator: ",")
			+ "]"
		}
		.joined(separator: ",")
		+ "]"
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
		"multmatrix(m = \(transform.scadString)) \(body.scadString(environment: environment))"
	}
}

public extension Geometry3D {
	func transform(_ transform: AffineTransform) -> Geometry3D {
		Transform(transform: transform, body: self)
	}

	func shear(_ axis: Axis3D, along otherAxis: Axis3D, factor: Double) -> Geometry3D {
		precondition(axis != otherAxis, "Shearing requires two different axes")
		let axes: [Axis3D] = [.x, .y, .z]
		let row = axes.firstIndex(of: axis)!
		let column = axes.firstIndex(of: otherAxis)!

		var t = AffineTransform.identity
		t[row, column] = factor
		return transform(t)
	}
}
