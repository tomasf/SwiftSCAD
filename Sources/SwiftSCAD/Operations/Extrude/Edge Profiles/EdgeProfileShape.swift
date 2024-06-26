import Foundation

internal protocol EdgeProfileShape {
    func shape(angle: Angle) -> any Geometry2D

    var height: Double { get }
    func inset(at z: Double) -> Double

    func convexMask(shape: any Geometry2D, extrusionHeight: Double) -> any Geometry3D
}

internal extension EdgeProfile {
    var profileShape: any EdgeProfileShape {
        switch self {
        case .fillet(let radius):
            Fillet(radius: radius)
        case .chamfer(let width, let height):
            Chamfer(width: width, height: height)
        case .chamferedFillet(let radius, let overhang):
            ChamferedFillet(radius: radius, overhang: overhang)
        }
    }
}

extension EdgeProfileShape {
    func mask(shape: any Geometry2D, extrusionHeight: Double, method: EdgeProfile.Method) -> any Geometry3D {
        switch method {
        case .layered (let layerHeight):
            layeredMask(shape: shape, extrusionHeight: extrusionHeight, layerHeight: layerHeight)
        case .convexHull:
            convexMask(shape: shape, extrusionHeight: extrusionHeight)
        }
    }

    @UnionBuilder3D
    func layeredMask(shape: any Geometry2D, extrusionHeight: Double, layerHeight: Double) -> any Geometry3D {
        let layerCount = Int(ceil(height / layerHeight))
        let effectiveHeight = Double(layerCount) * layerHeight

        for l in 0...layerCount {
            let z = Double(l) * layerHeight
            shape.offset(amount: -inset(at: z), style: .round)
                .extruded(height: extrusionHeight - effectiveHeight + z)
        }
    }
}
