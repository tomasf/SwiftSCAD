//
//  Union.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Intersection3D: Geometry3D {
	let children: [Geometry3D]

	func scadString(environment: Environment) -> String {
		SCADCall(name: "intersection", body: GeometrySequence(children: children))
			.scadString(environment: environment)
	}
}

public func Intersection(@SequenceBuilder _ content: () -> [Geometry3D]) -> Geometry3D {
	Intersection3D(children: content())
}

public extension Geometry3D {
	func intersection(@UnionBuilder with other: () -> Geometry3D) -> Geometry3D {
		Intersection3D(children: [self, other()])
	}
}


struct Intersection2D: Geometry2D {
	let children: [Geometry2D]

	func scadString(environment: Environment) -> String {
		SCADCall(name: "intersection", body: GeometrySequence(children: children))
			.scadString(environment: environment)
	}
}

public func Intersection(@SequenceBuilder _ content: () -> [Geometry2D]) -> Geometry2D {
	Intersection2D(children: content())
}

public extension Geometry2D {
	func intersection(@UnionBuilder with other: () -> Geometry2D) -> Geometry2D {
		Intersection2D(children: [self, other()])
	}
}
