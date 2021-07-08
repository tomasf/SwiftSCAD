import Foundation

public func Translate(_ distance: Vector3D, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Translate3D(distance: distance, body: body())
}

public func Translate(x: Double = 0, y: Double = 0, z: Double = 0, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Translate3D(distance: [x, y, z], body: body())
}

public func Translate(_ distance: Vector2D, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Translate2D(distance: distance, body: body())
}

public func Translate(x: Double = 0, y: Double = 0, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Translate2D(distance: [x, y], body: body())
}

public func Scale(_ scale: Vector3D, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Scale3D(scale: scale, body: body())
}

public func Scale(x: Double = 1, y: Double = 1, z: Double = 1, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Scale3D(scale: Vector3D(x: x, y: y, z: z), body: body())
}

public func Scale(_ factor: Double, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Scale3D(scale: Vector3D(x: factor, y: factor, z: factor), body: body())
}

public func Scale(_ scale: Vector2D, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Scale2D(scale: scale, body: body())
}

public func Scale(_ factor: Double, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Scale2D(scale: [factor, factor], body: body())
}

public func Scale(x: Double = 1, y: Double = 1, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Scale2D(scale: Vector2D(x: x, y: y), body: body())
}

public func Rotate(_ angles: [Angle], @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	precondition(angles.count == 3, "Rotate3D needs three angles")
	return Rotate3D(x: angles[0], y: angles[1], z: angles[2], body: body())
}

public func Rotate(x: Angle = 0, y: Angle = 0, z: Angle = 0, @UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	Rotate3D(x: x, y: y, z: z, body: body())
}

public func Rotate(_ angle: Angle, @UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	Rotate2D(angle: angle, body: body())
}
