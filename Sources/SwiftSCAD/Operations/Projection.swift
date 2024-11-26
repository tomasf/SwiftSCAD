import Foundation

internal struct Projection: Geometry2D {
    let body: any Geometry3D
    let mode: Mode

    enum Mode {
        case whole
        case slice (z: Double)
    }

    private var parameters: CodeFragment.Parameters {
        switch mode {
        case .whole: [:]
        case .slice: ["cut": true]
        }
    }

    private var appliedBody: any Geometry3D {
        switch mode {
        case .whole: body
        case .slice (let z): body.translated(z: -z)
        }
    }

    func evaluated(in environment: EnvironmentValues) -> Output2D {
        let environment = environment.applyingTransform(.scaling(z: 0))
        let bodyOutput = appliedBody.evaluated(in: environment)
        return .init(
            codeFragment: .init(module: "projection", parameters: parameters, body: [bodyOutput.codeFragment]),
            boundary: bodyOutput.boundary.map(\.xy),
            elements: bodyOutput.elements
        )
    }
}

public extension Geometry3D {
    /// Creates a 2D projection of the 3D geometry by flattening it against the XY plane.
    ///
    /// Projection is a technique used to reduce 3D geometry into a 2D shape by "compressing" all points along the Z-axis.
    /// This results in a 2D representation of the 3D object's outline as it would appear from above, effectively "flattening" it against the XY plane.
    ///
    /// ### Example
    /// ```swift
    /// let sphere = Sphere(radius: 10)
    /// let projectedSphere = sphere.projected()
    /// // The result is a 2D circle with the same radius as the sphere's base.
    /// ```
    ///
    /// - Returns: A `Geometry2D` representing the 2D projection of the 3D geometry onto the XY plane.
    func projected() -> any Geometry2D {
        Projection(body: self, mode: .whole)
    }

    /// Creates a 2D projection of the 3D geometry by slicing it at a specific Z height and projecting the resulting cross-section onto the XY plane.
    ///
    /// This method differs from `projected()` by focusing on a single cross-section of the geometry at the specified Z height.
    /// The slicing operation isolates the portion of the geometry that intersects the Z height, producing a 2D outline of that slice.
    ///
    /// ### How It Works
    /// - The `slicingAtZ` parameter defines the Z height where the 3D geometry is "cut."
    /// - The resulting cross-section is then projected onto the XY plane as a 2D shape.
    ///
    /// ### Example
    /// ```swift
    /// let truncatedCone = Cylinder(bottomDiameter: 10, topDiameter: 5, height: 15)
    /// let slicedProjection = truncatedCone.projected(atZ: 5)
    /// // The result is a 2D circle with a diameter representing the cone's cross-section at Z = 5.
    /// ```
    ///
    /// - Parameter z: The Z height at which the cross-section is taken before projection.
    /// - Returns: A `Geometry2D` representing the 2D shape of the cross-section at the specified Z height.
    func projected(slicedAt z: Double) -> any Geometry2D {
        Projection(body: self, mode: .slice(z: z))
    }
}
