//
//  Geometry3D.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

protocol Geometry3D {
	func generateOutput(environment: Environment) -> String
}

protocol Geometry2D {
	func generateOutput(environment: Environment) -> String
}


@_functionBuilder struct UnionBuilder {
	static func buildBlock(_ children: Geometry3D...) -> Geometry3D {
		if children.count > 1 {
			return Union3D(children: children)
		} else {
			return children[0]
		}
	}

	static func buildBlock(_ children: Geometry2D...) -> Geometry2D {
		if children.count > 1 {
			return Union2D(children: children)
		} else {
			return children[0]
		}
	}
}

extension Sequence {
	func forEach(@UnionBuilder _ transform: (Element) -> Geometry3D) -> Geometry3D {
		Union3D(children: map(transform))
	}

	func forEach(@UnionBuilder _ transform: (Element) -> Geometry2D) -> Geometry2D {
		Union2D(children: map(transform))
	}
}

struct Empty: Geometry3D, Geometry2D {
	func generateOutput(environment: Environment) -> String {
		""
	}
}
