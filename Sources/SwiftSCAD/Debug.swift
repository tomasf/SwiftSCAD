//
//  Debug.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

public struct Highlight3D: Geometry3D {
	let body: Geometry3D

	public func generateOutput(environment: Environment) -> String {
		return "#" + body.generateOutput(environment: environment)
	}
}

public struct Highlight2D: Geometry2D {
	let body: Geometry2D

	public func generateOutput(environment: Environment) -> String {
		return "#" + body.generateOutput(environment: environment)
	}
}

public extension Geometry2D {
	func highlighted() -> Geometry2D {
		Highlight2D(body: self)
	}
}

public extension Geometry3D {
	func highlighted() -> Geometry3D {
		Highlight3D(body: self)
	}
}
