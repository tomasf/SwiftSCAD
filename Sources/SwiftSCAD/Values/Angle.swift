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

extension Angle: SCADValue {
	public var scadString: String {
		degrees.scadString
	}
}

extension Angle: CustomDebugStringConvertible {
	public var debugDescription: String {
		"\(degrees)°"
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

extension Angle: Comparable {
	public static func +(_ a: Angle, _ b: Angle) -> Angle {
		Angle(radians: a.radians + b.radians)
	}

	public static func -(_ a: Angle, _ b: Angle) -> Angle {
		Angle(radians: a.radians - b.radians)
	}

	public static func *(_ a: Angle, _ b: Double) -> Angle {
		Angle(radians: a.radians * b)
	}

	public static func /(_ a: Angle, _ b: Double) -> Angle {
		Angle(radians: a.radians / b)
	}

	public static func /(_ a: Angle, _ b: Angle) -> Double {
		a.radians / b.radians
	}

	public static func <(_ a: Angle, _ b: Angle) -> Bool {
		a.radians < b.radians
	}

	public static func >(_ a: Angle, _ b: Angle) -> Bool {
		a.radians > b.radians
	}

	public static func ==(_ a: Angle, _ b: Angle) -> Bool {
		a.radians == b.radians
	}

	public static prefix func -(_ a: Angle) -> Angle {
		Angle(radians: -a.radians)
	}
}

extension Angle: SignedNumeric {
	public init?<T>(exactly source: T) where T : BinaryInteger {
		self.init(radians: Double(source))
	}

	public var magnitude: Angle {
		Angle(radians: fabs(radians))
	}

	public static func *= (lhs: inout Angle, rhs: Angle) {
		lhs = lhs * rhs
	}

	public typealias Magnitude = Angle

	public static func *(_ a: Angle, _ b: Angle) -> Angle {
		Angle(radians: a.radians * b.radians)
	}
}

extension Angle: Strideable {
	public typealias Stride = Angle

	public func advanced(by n: Angle) -> Angle {
		self + n
	}

	public func distance(to other: Angle) -> Angle {
		other - self
	}
}

postfix operator °

public extension Double {
	static postfix func °(_ a: Double) -> Angle {
		Angle(degrees: a)
	}
}

public extension Angle {
	var sin: Double { Darwin.sin(radians) }
	var cos: Double { Darwin.cos(radians) }
	var tan: Double { Darwin.tan(radians) }

	static func asin(_ value: Double) -> Angle {
		Angle(radians: Darwin.asin(value))
	}

	static func acos(_ value: Double) -> Angle {
		Angle(radians: Darwin.acos(value))
	}

	static func atan(_ value: Double) -> Angle {
		Angle(radians: Darwin.atan(value))
	}
}
