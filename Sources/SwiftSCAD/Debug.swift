//
//  Debug.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Highlight3D: Geometry3D {
	let body: Geometry3D

	func generateOutput(environment: Environment) -> String {
		return "#" + body.generateOutput(environment: environment)
	}
}

struct Highlight2D: Geometry2D {
	let body: Geometry2D

	func generateOutput(environment: Environment) -> String {
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


struct Only3D: Geometry3D {
	let body: Geometry3D

	func generateOutput(environment: Environment) -> String {
		return "!" + body.generateOutput(environment: environment)
	}
}

struct Only2D: Geometry2D {
	let body: Geometry2D

	func generateOutput(environment: Environment) -> String {
		return "!" + body.generateOutput(environment: environment)
	}
}

public extension Geometry2D {
	func only() -> Geometry2D {
		Only2D(body: self)
	}
}

public extension Geometry3D {
	func only() -> Geometry3D {
		Only3D(body: self)
	}
}


struct Background3D: Geometry3D {
	let body: Geometry3D

	func generateOutput(environment: Environment) -> String {
		return "%" + body.generateOutput(environment: environment)
	}
}

struct Background2D: Geometry2D {
	let body: Geometry2D

	func generateOutput(environment: Environment) -> String {
		return "%" + body.generateOutput(environment: environment)
	}
}

public extension Geometry2D {
	func background() -> Geometry2D {
		Background2D(body: self)
	}
}

public extension Geometry3D {
	func background() -> Geometry3D {
		Background3D(body: self)
	}
}
