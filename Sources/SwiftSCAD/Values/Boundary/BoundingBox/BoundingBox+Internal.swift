import Foundation

extension BoundingBox {
    func translation(for alignment: GeometryAlignment<V>) -> V {
        alignment.values.map { axis, axisAlignment in
            axisAlignment?.translation(origin: minimum[axis], size: size[axis]) ?? 0
        }.vector
    }
}

extension BoundingBox: CustomDebugStringConvertible {
    public var debugDescription: String {
        "[min: \(minimum), max: \(maximum)]"
    }
}

extension BoundingBox2D? {
    func requireNonNil() -> BoundingBox2D {
        guard let box = self else {
            preconditionFailure("Bounding box was empty")
        }
        return box
    }
}

extension BoundingBox3D? {
    func requireNonNil() -> BoundingBox3D {
        guard let box = self else {
            preconditionFailure("Bounding box was empty")
        }
        return box
    }
}
