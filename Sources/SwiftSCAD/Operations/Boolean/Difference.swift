import Foundation

struct Difference3D: CoreGeometry3D {
	let positive: Geometry3D
	let negative: Geometry3D

	init(positive: Geometry3D, negative: Geometry3D) {
		self.positive = positive
		self.negative = negative
	}

	func call(in environment: Environment) -> SCADCall {
		SCADCall(name: "difference", body: GeometrySequence(children: [positive, negative]))
	}
}

public extension Geometry3D {
	/// Subtract other geometry from this geometry
	///
    /// ## Example
	/// ```swift
    /// Box([10, 10, 5], center: .all)
    ///     .subtracting {
    ///        Cylinder(diameter: 4, height: 3)
    ///     }
	/// ```
	///
	/// - Parameters:
	///   - negative: The negative geometry to subtract
	/// - Returns: The new geometry

    func subtracting(@UnionBuilder _ negative: () -> Geometry3D) -> Geometry3D {
		Difference3D(positive: self, negative: negative())
	}
}


struct Difference2D: CoreGeometry2D {
	let positive: Geometry2D
	let negative: Geometry2D

	init(positive: Geometry2D, negative: Geometry2D) {
		self.positive = positive
		self.negative = negative
	}

	func call(in environment: Environment) -> SCADCall {
		SCADCall(name: "difference", body: GeometrySequence(children: [positive, negative]))
	}
}

public extension Geometry2D {
    /// Subtract other geometry from this geometry
    ///
    /// ## Example
    /// ```swift
    /// Rectangle([10, 10], center: .all)
    ///     .subtracting {
    ///        Circle(diameter: 4)
    ///     }
    /// ```
    ///
    /// - Parameters:
    ///   - negative: The negative geometry to subtract
    /// - Returns: The new geometry

	func subtracting(@UnionBuilder _ negative: () -> Geometry2D) -> Geometry2D {
		Difference2D(positive: self, negative: negative())
	}
}
