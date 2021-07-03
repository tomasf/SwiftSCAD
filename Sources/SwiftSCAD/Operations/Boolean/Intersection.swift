//
//  Union.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Intersection3D: Geometry3D {
	let children: [Geometry3D]

	init(@ListBuilder _ content: () -> [Geometry3D]) {
		children = content()
	}

	func generateOutput(environment: Environment) -> String {
		let childCode = children.map { $0.generateOutput(environment: environment) }
			.joined()

		return "intersection() {\n\(childCode)\n}"
	}
}

public func Intersection(@ListBuilder _ content: () -> [Geometry3D]) -> Geometry3D {
	Intersection3D(content)
}


struct Intersection2D: Geometry2D {
	let children: [Geometry2D]

	init(@ListBuilder _ content: () -> [Geometry2D]) {
		children = content()
	}

	func generateOutput(environment: Environment) -> String {
		let childCode = children.map { $0.generateOutput(environment: environment) }
			.joined()

		return "intersection() {\n\(childCode)\n}"
	}
}

public func Intersection(@ListBuilder _ content: () -> [Geometry2D]) -> Geometry2D {
	Intersection2D(content)
}
