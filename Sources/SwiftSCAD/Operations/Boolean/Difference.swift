//
//  Union.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Difference3D: Geometry3D {
	let positive: Geometry3D
	let negative: Geometry3D

	init(positive: Geometry3D, negative: Geometry3D) {
		self.positive = positive
		self.negative = negative
	}

	func generateOutput(environment: Environment) -> String {
		let posCode = positive.generateOutput(environment: environment)
		let negCode = negative.generateOutput(environment: environment)
		return "difference() {\n\(posCode)\n\(negCode)\n}"
	}
}

func Difference(@UnionBuilder _ positive: () -> Geometry3D, @UnionBuilder subtracting negative: () -> Geometry3D) -> Difference3D {
	Difference3D(positive: positive(), negative: negative())
}
