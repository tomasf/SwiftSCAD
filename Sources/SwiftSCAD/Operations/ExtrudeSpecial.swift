import Foundation

public enum ExtrusionZSides {
	case top
	case bottom
	case both
}

public extension Geometry2D {
	private func extrude(height: Double, topRadius radius: Double, layerHeight: Double) -> Geometry3D {
		return ForEach(stride(from: 0.0, through: radius, by: layerHeight)) { z in
			self
				.offset(amount: (Angle.asin(z / radius).cos - 1) * radius, style: .round)
				.extrude(height: height - radius + z)
		}
	}

	private func extrude(height: Double, topChamferSize chamferSize: Double, layerHeight: Double) -> Geometry3D {
		return ForEach(stride(from: 0.0, through: chamferSize, by: layerHeight)) { z in
			self
				.offset(amount: -z, style: .round)
				.extrude(height: height - chamferSize + z)
		}
	}

	func extrude(height: Double, radius: Double, layerHeight: Double, sides: ExtrusionZSides = .top) -> Geometry3D {
		switch sides {
		case .top:
			return extrude(height: height, topRadius: radius, layerHeight: layerHeight)
		case .bottom:
			return extrude(height: height, topRadius: radius, layerHeight: layerHeight)
				.scale(z: -1)
				.translate(z: height)
		case .both:
			return Union {
				extrude(height: height / 2, radius: radius, layerHeight: layerHeight, sides: .top)
					.translate(z: height / 2)
				extrude(height: height / 2, radius: radius, layerHeight: layerHeight, sides: .bottom)
			}
		}
	}

	func extrude(height: Double, chamferSize: Double, layerHeight: Double, sides: ExtrusionZSides = .top) -> Geometry3D {
		switch sides {
		case .top:
			return extrude(height: height, topChamferSize: chamferSize, layerHeight: layerHeight)
		case .bottom:
			return extrude(height: height, topChamferSize: chamferSize, layerHeight: layerHeight)
				.scale(z: -1)
				.translate(z: height)
		case .both:
			return Union {
				extrude(height: height / 2, chamferSize: chamferSize, layerHeight: layerHeight, sides: .top)
					.translate(z: height / 2)
				extrude(height: height / 2, chamferSize: chamferSize, layerHeight: layerHeight, sides: .bottom)
			}
		}
	}
}
