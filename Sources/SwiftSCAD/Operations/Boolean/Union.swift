//
//  Union.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Union3D: Geometry3D {
	let children: [Geometry3D]

	init(children: [Geometry3D]) {
		self.children = children
	}

	func scadString(environment: Environment) -> String {
		let body = children.map { $0.scadString(environment: environment) }.joined(separator: "\n")
		return "union() {\n\(body)\n}"
	}
}

public func Union(@UnionBuilder _ body: () -> Geometry3D) -> Geometry3D {
	body()
}


struct Union2D: Geometry2D {
	let children: [Geometry2D]

	init(children: [Geometry2D]) {
		self.children = children
	}

	func scadString(environment: Environment) -> String {
		let body = children.map { $0.scadString(environment: environment) }.joined(separator: "\n")
		return "union() {\n\(body)\n}"
	}
}

public func Union(@UnionBuilder _ body: () -> Geometry2D) -> Geometry2D {
	body()
}
