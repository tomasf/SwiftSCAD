import Foundation

public struct AffineTransform {
	public var values: [[Double]]

	public init(_ values: [[Double]]) {
		precondition(
			values.count == 4 && values.allSatisfy { $0.count == 4},
			"AffineTransform requires 16 (4 x 4) elements"
		)
		self.values = values
	}

	public static var identity: AffineTransform {
		AffineTransform([
			[1, 0, 0, 0],
			[0, 1, 0, 0],
			[0, 0, 1, 0],
			[0, 0, 0, 1]
		])
	}

	public static func translate(x: Double = 0, y: Double = 0, z: Double = 0) -> AffineTransform {
		var transform = identity
		transform[0, 3] = x
		transform[1, 3] = y
		transform[2, 3] = z
		return transform
	}

	public static func translate(_ v: Vector3D) -> AffineTransform {
		translate(x: v.x, y: v.y, z: v.z)
	}

	public static func scale(x: Double = 1, y: Double = 1, z: Double = 1) -> AffineTransform {
		var transform = identity
		transform[0, 0] = x
		transform[1, 1] = y
		transform[2, 2] = z
		return transform
	}

	public static func scale(_ v: Vector3D) -> AffineTransform {
		scale(x: v.x, y: v.y, z: v.z)
	}

	private static func rotate(x: Angle) -> AffineTransform {
		var transform = identity
		transform[1, 1] = x.cos
		transform[1, 2] = -x.sin
		transform[2, 1] = x.sin
		transform[2, 2] = x.cos
		return transform
	}

	private static func rotate(y: Angle) -> AffineTransform {
		var transform = identity
		transform[0, 0] = y.cos
		transform[0, 2] = y.sin
		transform[2, 0] = -y.sin
		transform[2, 2] = y.cos
		return transform
	}

	private static func rotate(z: Angle) -> AffineTransform {
		var transform = identity
		transform[0, 0] = z.cos
		transform[0, 1] = -z.sin
		transform[1, 0] = z.sin
		transform[1, 1] = z.cos
		return transform
	}

	public static func rotate(x: Angle = 0, y: Angle = 0, z: Angle = 0) -> AffineTransform {
		return identity
			.concatenated(with: rotate(x: x))
			.concatenated(with: rotate(y: y))
			.concatenated(with: rotate(z: z))
	}

	public static func rotate(_ a: [Angle]) -> AffineTransform {
		assert(a.count == 3, "Rotate expects three angles")
		return rotate(x: a[0], y: a[1], z: a[2])
	}

	public static func shear(_ axis: Axis3D, along otherAxis: Axis3D, factor: Double) -> AffineTransform {
		precondition(axis != otherAxis, "Shearing requires two distinct axes")

		let order: [Axis3D] = [.x, .y, .z]
		let row = order.firstIndex(of: axis)!
		let column = order.firstIndex(of: otherAxis)!

		var t = AffineTransform.identity
		t[row, column] = factor
		return t
	}

	public func concatenated(with other: AffineTransform) -> AffineTransform {
		AffineTransform(
			(0..<4).map { row in
				(0..<4).map { column in
					(0..<4).map { i in
						other[row, i] * self[i, column]
					}.reduce(0, +)
				}
			}
		)
	}

	public func translate(x: Double = 0, y: Double = 0, z: Double = 0) -> AffineTransform {
		concatenated(with: .translate(x: x, y: y, z: z))
	}

	public func translate(_ v: Vector3D) -> AffineTransform {
		concatenated(with: .translate(v))
	}

	public func scale(_ v: Vector3D) -> AffineTransform {
		concatenated(with: .scale(v))
	}

	public func scale(x: Double = 1, y: Double = 1, z: Double = 1) -> AffineTransform {
		concatenated(with: .scale(x: x, y: y, z: z))
	}

	public func rotate(_ a: [Angle]) -> AffineTransform {
		concatenated(with: .rotate(a))
	}

	public func rotate(x: Angle = 0, y: Angle = 0, z: Angle = 0) -> AffineTransform {
		concatenated(with: .rotate(x: x, y: y, z: z))
	}

	func shear(_ axis: Axis3D, along otherAxis: Axis3D, factor: Double) -> AffineTransform {
		concatenated(with: .shear(axis, along: otherAxis, factor: factor))
	}

	public subscript(_ row: Int, _ column: Int) -> Double {
		get {
			assert((0...3).contains(row), "Row index out of range")
			assert((0...3).contains(column), "Column index out of range")
			return values[row][column]
		}
		set {
			assert((0...3).contains(row), "Row index out of range")
			assert((0...3).contains(column), "Column index out of range")
			values[row][column] = newValue
		}
	}
}


extension AffineTransform: SCADValue {
	public var scadString: String {
		values.scadString
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
		transform(.shear(axis, along: otherAxis, factor: factor))
	}
}
