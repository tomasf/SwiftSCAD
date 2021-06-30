//
//  Axes.swift
//  Geometry3DGenerator
//
//  Created by Tomas Franzén on 2021-06-28.
//

import Foundation

struct Axes3D: OptionSet {
	let rawValue: Int
	static let x = Axes3D(rawValue: 1 << 0)
	static let y = Axes3D(rawValue: 1 << 1)
	static let z = Axes3D(rawValue: 1 << 2)

	static let xy: Axes3D = [.x, .y]
	static let all: Axes3D = [.x, .y, .z]

	var inverted: Axes3D {
		Axes3D(rawValue: (~rawValue) & 0x7)
	}
}

extension Axes3D: ExpressibleByBooleanLiteral {
	typealias BooleanLiteralType = Bool

	init(booleanLiteral value: Bool) {
		self = value ? .all : []
	}
}


struct Axes2D: OptionSet {
	let rawValue: Int
	static let x = Axes2D(rawValue: 1 << 0)
	static let y = Axes2D(rawValue: 1 << 1)

	static let xy: Axes2D = [.x, .y]
	static let all: Axes2D = [.x, .y]

	var inverted: Axes2D {
		Axes2D(rawValue: (~rawValue) & 0x3)
	}
}

extension Axes2D: ExpressibleByBooleanLiteral {
	typealias BooleanLiteralType = Bool

	init(booleanLiteral value: Bool) {
		self = value ? .all : []
	}
}
