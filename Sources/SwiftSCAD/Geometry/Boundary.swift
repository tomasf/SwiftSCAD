import Foundation

public struct Boundary<V: Vector> {
    private let points: [V]

    internal init(points: [V]) {
        self.points = points
    }
}

internal extension Boundary {
    static var empty: Boundary { .init(points: []) }

    static func box(_ size: V) -> Boundary {
        let cornerCount = Int(pow(2.0, Double(V.elementCount)))
        return .init(points: (0..<cornerCount).map { cornerIndex in
            V(elements: (0..<V.elementCount).map {
                Double((cornerIndex >> $0) & 0x01) * size[$0]
            })
        })
    }

    static func union(_ boundaries: [Boundary]) -> Boundary {
        .init(points: boundaries.flatMap(\.points))
    }
}

internal extension Boundary {
    func map<OutputV: Vector>(_ function: (V) -> OutputV) -> Boundary<OutputV> {
        .init(points: points.map(function))
    }

    func map<OutputV: Vector>(_ function: (V) -> [OutputV]) -> Boundary<OutputV> {
        .init(points: points.flatMap(function))
    }

    func translated(_ translation: V) -> Boundary<V> {
        transformed(.translation(translation))
    }

    func transformed(_ transform: V.Transform) -> Boundary<V> {
        map { transform.apply(to: $0) }
    }

    func min(_ axis: V.Axes.Axis) -> Double? {
        points.map { $0[axis] }.min()
    }

    func max(_ axis: V.Axes.Axis) -> Double? {
        points.map { $0[axis] }.max()
    }
}

internal extension Boundary {
    enum MergeStrategy {
        case union
        case first
        case custom (([Boundary]) -> Boundary)

        func apply(_ bounds: [Boundary]) -> Boundary {
            switch self {
            case .union:
                    .union(bounds)
            case .first:
                bounds.first ?? .empty
            case .custom (let function):
                function(bounds)
            }
        }
    }
}

extension Boundary2D {
    func asFlat3D(z: Double = 0) -> Boundary<Vector3D> {
        map { Vector3D($0, z: z) }
    }

    func extruded(height: Double, topScale: Vector2D = [1, 1]) -> Boundary<Vector3D> {
        map { [Vector3D($0, z: 0), Vector3D($0 * topScale, z: height)] }
    }

    func extruded(angle fullAngle: Angle, facets: Environment.Facets) -> Boundary<Vector3D> {
        guard let maxX = max(.x) else { return .empty }
        let facetCount = facets.facetCount(circleRadius: maxX)
        let standing = asFlat3D().transformed(.rotation(x: 90°))

        return .union((0...facetCount).map {
            let angle = (fullAngle / Double(facetCount)) * Double($0)
            return standing.transformed(.rotation(z: angle))
        })
    }
}

typealias Boundary2D = Boundary<Vector2D>
typealias Boundary3D = Boundary<Vector3D>
