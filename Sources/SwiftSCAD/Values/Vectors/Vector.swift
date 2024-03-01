import Foundation

public protocol Vector {
    associatedtype Axes: SwiftSCAD.Axes
    associatedtype Transform: AffineTransform

    static var zero: Self { get }
    static prefix func -(_ v: Self) -> Self
    
    static func +(_ v1: Self, _ v2: Self) -> Self
    static func -(_ v1: Self, _ v2: Self) -> Self
    static func *(_ v1: Self, _ v2: Self) -> Self
    static func /(_ v1: Self, _ v2: Self) -> Self

    static func +(_ v: Self, _ s: Double) -> Self
    static func -(_ v: Self, _ s: Double) -> Self
    static func *(_ v: Self, _ d: Double) -> Self
    static func /(_ v: Self, _ d: Double) -> Self

    func distance(to other: Self) -> Double
    func point(alongLineTo other: Self, at fraction: Double) -> Self

    init(axis: Axes.Axis, value: Double, default: Double)
    func setting(axes: Axes, to: Double) -> Self
    subscript(_ axis: Axes.Axis) -> Double { get }
}

infix operator ×
infix operator ⋅

internal extension Vector {
    var vector3D: Vector3D {
        if let v3d = self as? Vector3D {
            return v3d
        } else if let v2d = self as? Vector2D {
            return .init(v2d, z: 0)
        } else {
            preconditionFailure()
        }
    }
}
