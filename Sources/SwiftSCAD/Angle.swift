//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-03.
//

import Foundation

public struct Angle {
	public let radians: Double

	public init(radians: Double) {
		self.radians = radians
	}

	public init(degrees: Double) {
		self.radians = degrees * .pi / 180.0
	}

	public var degrees: Double {
		radians / (.pi / 180.0)
	}
}

extension Angle {
	var scadString: String {
		String(format: "%.06f", degrees)
	}
}

extension Angle: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = Int
	public typealias FloatLiteralType = Double

	public init(floatLiteral degrees: Double) {
		self.init(degrees: degrees)
	}

	public init(integerLiteral degrees: Int) {
		self.init(degrees: Double(degrees))
	}
}

public extension Angle {
	static func +(_ a: Angle, _ b: Angle) -> Angle {
		Angle(radians: a.radians + b.radians)
	}

	static func -(_ a: Angle, _ b: Angle) -> Angle {
		Angle(radians: a.radians - b.radians)
	}

	static func <(_ a: Angle, _ b: Angle) -> Bool {
		a.radians < b.radians
	}

	static func >(_ a: Angle, _ b: Angle) -> Bool {
		a.radians > b.radians
	}

	static prefix func -(_ a: Angle) -> Angle {
		Angle(radians: -a.radians)
	}
}


public func sin(_ angle: Angle) -> Double {
	sin(angle.radians)
}

public func cos(_ angle: Angle) -> Double {
	cos(angle.radians)
}

public func tan(_ angle: Angle) -> Double {
	tan(angle.radians)
}
