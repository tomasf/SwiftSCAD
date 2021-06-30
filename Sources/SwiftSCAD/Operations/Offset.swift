//
//  Offset.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

struct Offset: Geometry2D {
	let body: Geometry2D
	let amount: Double
	let style: Style

	init(amount: Double, style: Style, @UnionBuilder body: () -> Geometry2D) {
		self.amount = amount
		self.style = style
		self.body = body()
	}

	func generateOutput(environment: Environment) -> String {
		let params: String

		switch style {
		case .round:
			params = "r = \(amount)"
		case .miter:
			params = "delta = \(amount)"
		case .bevel:
			params = "delta = \(amount), chamfer = true"
		}

		return "offset(\(params)) \(body.generateOutput(environment: environment))"
	}

	enum Style {
		case round
		case miter
		case bevel
	}

	enum Side {
		case outside
		case inside
		case both
	}
}

extension Geometry2D {
	func offset(amount: Double, style: Offset.Style) -> Geometry2D {
		Offset(amount: amount, style: style) { self }
	}

	func rounded(amount: Double, side: Offset.Side = .both) -> Geometry2D {
		var body: Geometry2D = self
		if side != .inside {
			body = body
				.offset(amount: -amount, style: .miter)
				.offset(amount: amount, style: .round)
		}
		if side != .outside {
			body = body
				.offset(amount: amount, style: .miter)
				.offset(amount: -amount, style: .round)
		}
		return body
	}
}
