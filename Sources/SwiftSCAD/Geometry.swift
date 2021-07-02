//
//  Geometry3D.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

public protocol Geometry3D {
	func generateOutput(environment: Environment) -> String
}

public protocol Geometry2D {
	func generateOutput(environment: Environment) -> String
}


@_functionBuilder public struct UnionBuilder {
	public static func buildBlock(_ children: Geometry3D...) -> Geometry3D {
		if children.count > 1 {
			return Union3D(children: children)
		} else {
			return children[0]
		}
	}

	static func buildIf(_ children: Geometry3D?...) -> Geometry3D {
		if children.count > 1 {
			return Union3D(children: children.compactMap { $0 })
		} else {
			return children[0] ?? Empty()
		}
	}


	public static func buildBlock(_ children: Geometry2D...) -> Geometry2D {
		if children.count > 1 {
			return Union2D(children: children)
		} else {
			return children[0]
		}
	}
}

public extension Sequence {
	func forEach(@UnionBuilder _ transform: (Element) -> Geometry3D) -> Geometry3D {
		Union3D(children: map(transform))
	}

	func forEach(@UnionBuilder _ transform: (Element) -> Geometry2D) -> Geometry2D {
		Union2D(children: map(transform))
	}
}

public struct Empty: Geometry3D, Geometry2D {
	public init() {}
	public func generateOutput(environment: Environment) -> String {
		""
	}
}
