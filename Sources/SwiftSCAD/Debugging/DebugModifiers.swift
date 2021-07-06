//
//  Debug.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Prefix3D: Geometry3D {
	let prefix: String
	let body: Geometry3D

	func scadString(environment: Environment) -> String {
		return prefix + body.scadString(environment: environment)
	}
}

struct Prefix2D: Geometry2D {
	let prefix: String
	let body: Geometry2D

	func scadString(environment: Environment) -> String {
		return prefix + body.scadString(environment: environment)
	}
}

public extension Geometry2D {
	func highlighted() -> Geometry2D {
		Prefix2D(prefix: "#", body: self)
	}

	func only() -> Geometry2D {
		Prefix2D(prefix: "!", body: self)
	}

	func background() -> Geometry2D {
		Prefix2D(prefix: "%", body: self)
	}

	func disabled() -> Geometry2D {
		Prefix2D(prefix: "*", body: self)
	}
}

public extension Geometry3D {
	func highlighted() -> Geometry3D {
		Prefix3D(prefix: "#", body: self)
	}

	func only() -> Geometry3D {
		Prefix3D(prefix: "!", body: self)
	}

	func background() -> Geometry3D {
		Prefix3D(prefix: "%", body: self)
	}

	func disabled() -> Geometry3D {
		Prefix3D(prefix: "*", body: self)
	}
}
