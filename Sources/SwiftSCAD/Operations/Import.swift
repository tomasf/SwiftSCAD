import Foundation

public struct Import3D: Geometry3D {
	let path: String
	let convexity: Int

	public init(path: String, convexity: Int = 2) {
		self.path = path
		self.convexity = convexity
	}

	public func scadString(environment: Environment) -> String {
		SCADCall(
			name: "import",
			params: [
				"file": path,
				"convexity": convexity
			]
		)
		.scadString(environment: environment)
	}
}

public struct Import2D: Geometry2D {
	let path: String
	let layer: String?
	let convexity: Int

	public init(path: String, dxfLayer: String? = nil, convexity: Int = 2) {
		self.path = path
		self.layer = dxfLayer
		self.convexity = convexity
	}

	public func scadString(environment: Environment) -> String {
		let params: [String: SCADValue?] = [
			"file": path,
			"layer": layer,
			"convexity": convexity
		]
		return SCADCall(
			name: "import",
			params: params.compactMapValues { $0 }
		)
		.scadString(environment: environment)
	}
}
