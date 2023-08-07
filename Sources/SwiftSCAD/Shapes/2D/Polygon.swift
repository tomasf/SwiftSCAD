import Foundation

/// A `Polygon` represents a two-dimensional shape that is defined by a series of connected points.
/// It can be initialized with either an array of `Vector2D` points or a `BezierPath`.
///
/// # Example
/// Creating a Polygon from points:
/// ```swift
/// let polygonFromPoints = Polygon([Vector2D(x: 0, y: 0), Vector2D(x: 10, y: 0), Vector2D(x: 5, y: 10)])
/// ```
/// Creating a Polygon from a Bezier path:
/// ```swift
/// let bezierPath = BezierPath(startPoint: .zero)
///                  .addingCubicCurve(controlPoint1: [10, 65], controlPoint2: [55, -20], end: [60, 40])
/// let polygonFromBezierPath = Polygon(bezierPath)
/// ```
public struct Polygon: CoreGeometry2D {
    let source: PolygonSource

    /// Creates a new `Polygon` instance with the specified points.
    ///
    /// - Parameter points: An array of `Vector2D` that defines the vertices of the polygon.
    public init(_ points: [Vector2D]) {
        source = Points(points: points)
    }

    /// Creates a new `Polygon` instance with the specified Bezier path.
    ///
    /// - Parameter bezierPath: A `BezierPath` that defines the shape of the polygon.
    public init(_ bezierPath: BezierPath) {
        source = bezierPath
    }

    func call(in environment: Environment) -> SCADCall {
        return SCADCall(
            name: "polygon",
            params: ["points": source.points(in: environment)]
        )
    }
}

protocol PolygonSource {
    func points(in environment: Environment) -> [Vector2D]
}

struct Points: PolygonSource {
    let points: [Vector2D]

    func points(in environment: Environment) -> [Vector2D] {
        self.points
    }
}

extension BezierPath: PolygonSource {
    func points(in environment: Environment) -> [Vector2D] {
        points(facets: environment.facets)
    }
}
