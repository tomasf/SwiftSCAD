import Foundation

public struct Polygon: Geometry2D {
	public let points: [Vector2D]

	public init(_ points: [Vector2D]) {
		self.points = points
	}

	public func scadString(environment: Environment) -> String {
		return SCADCall(
			name: "polygon",
			params: ["points": points]
		)
		.scadString(environment: environment)
	}
}
