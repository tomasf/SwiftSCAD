import Foundation

public typealias GeometryOutput2D = GeometryOutput<Vector2D>
public typealias GeometryOutput3D = GeometryOutput<Vector3D>

public struct GeometryOutput<V: Vector> {
    internal let scadCode: String
    internal let boundary: Boundary<V>
    internal let anchors: [Anchor: AffineTransform3D]

    private init(scadCode: String, boundary: Boundary<V>, anchors: [Anchor: AffineTransform3D]) {
        self.scadCode = scadCode
        self.boundary = boundary
        self.anchors = anchors
    }
}

extension GeometryOutput {
    func modifyingCode(_ function: (_ code: String) -> String) -> GeometryOutput<V> {
        .init(scadCode: function(scadCode), boundary: boundary, anchors: anchors)
    }

    func definingAnchors(_ anchors: [Anchor: AffineTransform3D]) -> GeometryOutput<V> {
        .init(scadCode: scadCode, boundary: boundary, anchors: self.anchors.merging(anchors) { $1 })
    }

    func modifyingBoundary(_ function: (Boundary<V>) -> Boundary<V>) -> GeometryOutput<V> {
        .init(scadCode: scadCode, boundary: function(boundary), anchors: anchors)
    }
}

extension GeometryOutput {
    // Without children
    init(invocation: Invocation, boundary: Boundary<V>) {
        scadCode = invocation.scadCode()
        self.boundary = boundary
        anchors = [:]
    }

    // 2D parent with 2D children
    init(
        invocation: Invocation,
        body: [any Geometry2D],
        bodyTransform: AffineTransform3D = .identity,
        environment: Environment,
        boundaryMergeStrategy: Boundary2D.MergeStrategy = .union
    ) where V == Vector2D {
        let newEnvironment = environment.applyingTransform(bodyTransform)
        let bodyOutputs = body.map { $0.output(in: newEnvironment) }

        let localBounds = bodyOutputs.map {
            $0.boundary.transformed(AffineTransform2D(bodyTransform))
        }

        scadCode = invocation.scadCode(body: bodyOutputs.map(\.scadCode))
        boundary = boundaryMergeStrategy.apply(localBounds)
        anchors = bodyOutputs.map(\.anchors)
            .reduce(into: [:]) { $0.merge($1) { a, _ in a }}
            .mapValues { $0.concatenated(with: bodyTransform) }
    }

    // 2D parent with 3D child
    init(
        invocation: Invocation,
        body: any Geometry3D,
        bodyTransform: AffineTransform3D = .identity,
        environment: Environment,
        boundaryMapping: ((Boundary3D) -> Boundary2D)
    ) where V == Vector2D {
        let newEnvironment = environment.applyingTransform(bodyTransform)
        let bodyOutput = body.output(in: newEnvironment)

        scadCode = invocation.scadCode(body: [bodyOutput.scadCode])
        boundary = boundaryMapping(bodyOutput.boundary.transformed(bodyTransform))
        anchors = bodyOutput.anchors
            .mapValues { $0.concatenated(with: bodyTransform) }
    }

    // 3D parent with 3D children
    init(
        invocation: Invocation,
        body: [any Geometry3D],
        bodyTransform: AffineTransform3D = .identity,
        environment: Environment,
        boundaryMergeStrategy: Boundary3D.MergeStrategy = .union
    ) where V == Vector3D {
        let newEnvironment = environment.applyingTransform(bodyTransform)
        let bodyOutputs = body.map { $0.output(in: newEnvironment) }

        let localBounds = bodyOutputs.map {
            $0.boundary.transformed(bodyTransform)
        }

        scadCode = invocation.scadCode(body: bodyOutputs.map(\.scadCode))
        boundary = boundaryMergeStrategy.apply(localBounds)
        anchors = bodyOutputs.map(\.anchors)
            .reduce(into: [:]) { $0.merge($1) { a, _ in a }}
            .mapValues { $0.concatenated(with: bodyTransform) }
    }

    // 3D parent with 2D child
    init(
        invocation: Invocation,
        body: any Geometry2D,
        bodyTransform: AffineTransform3D = .identity,
        environment: Environment,
        boundaryMapping: ((Boundary2D) -> Boundary3D)
    ) where V == Vector3D {
        let newEnvironment = environment.applyingTransform(bodyTransform)
        let bodyOutput = body.output(in: newEnvironment)

        scadCode = invocation.scadCode(body: [bodyOutput.scadCode])
        boundary = boundaryMapping(bodyOutput.boundary).transformed(bodyTransform)
        anchors = bodyOutput.anchors
            .mapValues { $0.concatenated(with: bodyTransform) }
    }
}

extension GeometryOutput {
    static var emptyLeaf: Self { .init(scadCode: ";", boundary: .empty, anchors: [:]) }
}

extension GeometryOutput<Vector2D>: Geometry2D {
    public func output(in environment: Environment) -> Self {
        self
    }
}

extension GeometryOutput<Vector3D>: Geometry3D {
    public func output(in environment: Environment) -> Self {
        self
    }
}
