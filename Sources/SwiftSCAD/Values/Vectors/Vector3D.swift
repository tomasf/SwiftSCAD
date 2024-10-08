import Foundation

/// A unitless vector representing distances, sizes or scales in three dimensions
///
/// ## Examples
/// ```swift
/// let v1 = Vector3D(x: 10, y: 15, z: 5)
/// let v2: Vector3D = [10, 15, 5]
/// ```
public struct Vector3D: ExpressibleByArrayLiteral, SCADValue, Hashable, Sendable {
    public var x: Double
    public var y: Double
    public var z: Double

    public static let zero = Vector3D(x: 0, y: 0, z: 0)

    public init(x: Double = 0, y: Double = 0, z: Double = 0) {
        precondition(x.isFinite, "Vector elements can't be NaN or infinite")
        precondition(y.isFinite, "Vector elements can't be NaN or infinite")
        precondition(z.isFinite, "Vector elements can't be NaN or infinite")
        self.x = x
        self.y = y
        self.z = z
    }

    public init(_ x: Double, _ y: Double, _ z: Double) {
        self.init(x: x, y: y, z: z)
    }

    public init(_ xy: Vector2D, z: Double = 0) {
        self.init(x: xy.x, y: xy.y, z: z)
    }

    public init(arrayLiteral: Double...) {
        precondition(arrayLiteral.count == 3, "Vector3D requires exactly three elements")
        self.init(x: arrayLiteral[0], y: arrayLiteral[1], z: arrayLiteral[2])
    }

    public var scadString: String {
        [x, y, z].scadString
    }
}

public extension Vector3D {
    /// Create a vector where some axes are set to a given value and the others are zero
    /// - Parameters:
    ///   - axis: The axes to set
    ///   - value: The value to use
    ///   - default: The value to use for the other axes
    init(axis: Axis3D, value: Double, default defaultValue: Double = 0) {
        let x = (axis == .x) ? value : defaultValue
        let y = (axis == .y) ? value : defaultValue
        let z = (axis == .z) ? value : defaultValue
        self.init(x, y, z)
    }

    internal func with(_ axes: Axes3D, as value: Double) -> Vector3D {
        Vector3D(
            x: axes.contains(.x) ? value : x,
            y: axes.contains(.y) ? value : y,
            z: axes.contains(.z) ? value : z
        )
    }

    /// Make a new vector by changing one element
    /// - Parameters:
    ///   - axis: The axis to change
    ///   - value: The new value
    /// - Returns: A modified vector
    func with(_ axis: Axis3D, as value: Double) -> Vector3D {
        Vector3D(
            x: axis == .x ? value : x,
            y: axis == .y ? value : y,
            z: axis == .z ? value : z
        )
    }

    subscript(_ axis: Axis3D) -> Double {
        switch axis {
        case .x: return x
        case .y: return y
        case .z: return z
        }
    }
}

public extension Vector3D {
    var xy: Vector2D {
        Vector2D(x:x, y:y)
    }

    var squaredEuclideanNorm: Double {
        x * x + y * y + z * z
    }
}

extension Vector3D: Vector {
    public typealias Transform = AffineTransform3D
    public typealias Axes = Axes3D
    public static let elementCount = 3

    public var elements: [Double] {
        [x, y, z]
    }

    public init(elements e: [Double]) {
        self.init(e[0], e[1], e[2])
    }

    public static func min(_ a: Self, _ b: Self) -> Self {
        Self(x: Swift.min(a.x, b.x), y: Swift.min(a.y, b.y), z: Swift.min(a.z, b.z))
    }

    public static func max(_ a: Self, _ b: Self) -> Self {
        Self(x: Swift.max(a.x, b.x), y: Swift.max(a.y, b.y), z: Swift.max(a.z, b.z))
    }
}

extension Vector3D: CustomDebugStringConvertible {
    public var debugDescription: String {
        String(format: "[%g, %g, %g]", x, y, z)
    }
}
