import Foundation

/// A structure representing a rotation in 3D space.
public struct Rotation3D {
    internal let x: Angle
    internal let y: Angle
    internal let z: Angle

    /// Creates a `Rotation3D` structure with specified angles for each principal axis (X, Y, and Z).
    /// The rotation is applied in order: first around the X axis, then the Y axis, and finally the Z axis.
    ///
    /// - Parameters:
    ///   - x: The rotation angle around the X axis. Defaults to 0 degrees if not specified.
    ///   - y: The rotation angle around the Y axis. Defaults to 0 degrees if not specified.
    ///   - z: The rotation angle around the Z axis. Defaults to 0 degrees if not specified.
    init(x: Angle = 0°, y: Angle = 0°, z: Angle = 0°) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Creates a `Rotation3D` instance with a specified angle around a specified axis.
    ///
    /// This initializer allows creating a rotation by specifying a single angle and the axis
    /// around which the rotation is applied. The other two axes will have no rotation.
    ///
    /// - Parameters:
    ///   - angle: The rotation angle around the specified axis.
    ///   - axis: The axis around which the rotation is applied (`Axis3D.x`, `Axis3D.y`, or `Axis3D.z`).
    init(angle: Angle, axis: Axis3D) {
        switch axis {
        case .x: self.init(x: angle)
        case .y: self.init(y: angle)
        case .z: self.init(z: angle)
        }
    }
}

extension Rotation3D: ExpressibleByArrayLiteral {
    /// Allows initializing a `Rotation3D` instance using an array literal of three angles.
    ///
    /// The array must contain exactly three angles, corresponding to the rotation around the X, Y, and Z axes, respectively.
    /// - Parameter angles: An array literal containing three angles.
    public init(arrayLiteral angles: Angle...) {
        assert(angles.count == 3, "Rotation3D requires three angles")
        self.init(x: angles[0], y: angles[1], z: angles[2])
    }
}