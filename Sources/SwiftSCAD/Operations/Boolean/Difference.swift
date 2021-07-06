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

	func scadString(environment: Environment) -> String {
		let posCode = positive.scadString(environment: environment)
		let negCode = negative.scadString(environment: environment)
		return "difference() {\n\(posCode)\n\(negCode)\n}"
	}
}

public func Difference(@UnionBuilder _ positive: () -> Geometry3D, @UnionBuilder subtracting negative: () -> Geometry3D) -> Geometry3D {
	Difference3D(positive: positive(), negative: negative())
}

public extension Geometry3D {
	func subtracting(@UnionBuilder _ negative: () -> Geometry3D) -> Geometry3D {
		Difference3D(positive: self, negative: negative())
	}
}


struct Difference2D: Geometry2D {
	let positive: Geometry2D
	let negative: Geometry2D

	init(positive: Geometry2D, negative: Geometry2D) {
		self.positive = positive
		self.negative = negative
	}

	func scadString(environment: Environment) -> String {
		let posCode = positive.scadString(environment: environment)
		let negCode = negative.scadString(environment: environment)
		return "difference() {\n\(posCode)\n\(negCode)\n}"
	}
}

public func Difference(@UnionBuilder _ positive: () -> Geometry2D, @UnionBuilder subtracting negative: () -> Geometry2D) -> Geometry2D {
	Difference2D(positive: positive(), negative: negative())
}

public extension Geometry2D {
	func subtracting(@UnionBuilder _ negative: () -> Geometry2D) -> Geometry2D {
		Difference2D(positive: self, negative: negative())
	}
}
