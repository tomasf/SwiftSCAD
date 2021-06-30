//
//  ForEach.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct ForEach3D: Geometry3D {
	let body: Geometry3D

	init<C: Sequence>(_ sequence: C, @UnionBuilder body: (C.Element) -> Geometry3D) {
		self.body = Union3D(children: sequence.map(body))
	}

	func generateOutput(environment: Environment) -> String {
		body.generateOutput(environment: environment)
	}
}

func ForEach<C: Sequence>(_ sequence: C, @UnionBuilder body: (C.Element) -> Geometry3D) -> Geometry3D {
	ForEach3D(sequence, body: body)
}


struct ForEach2D: Geometry2D {
	let body: Geometry2D

	init<C: Sequence>(_ sequence: C, @UnionBuilder body: (C.Element) -> Geometry2D) {
		self.body = Union2D(children: sequence.map(body))
	}

	func generateOutput(environment: Environment) -> String {
		body.generateOutput(environment: environment)
	}
}

func ForEach<C: Sequence>(_ sequence: C, @UnionBuilder body: (C.Element) -> Geometry2D) -> Geometry2D {
	ForEach2D(sequence, body: body)
}
