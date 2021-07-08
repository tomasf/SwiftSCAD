import Foundation

public enum Axis3D: Int {
	case x
	case y
	case z
}

public struct Axes3D: OptionSet {
	public let rawValue: Int
	public static let x = Axes3D(rawValue: 1 << 0)
	public static let y = Axes3D(rawValue: 1 << 1)
	public static let z = Axes3D(rawValue: 1 << 2)

	public static let xy: Axes3D = [.x, .y]
	public static let all: Axes3D = [.x, .y, .z]

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	public init(axis: Axis3D) {
		self.init(rawValue: 1 << axis.rawValue)
	}

	public var inverted: Axes3D {
		Axes3D(rawValue: (~rawValue) & 0x7)
	}
}

extension Axes3D: ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = Bool

	public init(booleanLiteral value: Bool) {
		self = value ? .all : []
	}
}


public enum Axis2D: Int {
	case x
	case y
}

public struct Axes2D: OptionSet {
	public let rawValue: Int
	public static let x = Axes2D(rawValue: 1 << 0)
	public static let y = Axes2D(rawValue: 1 << 1)

	public static let xy: Axes2D = [.x, .y]
	public static let all: Axes2D = [.x, .y]

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	public init(axis: Axis2D) {
		self.init(rawValue: 1 << axis.rawValue)
	}

	public var inverted: Axes2D {
		Axes2D(rawValue: (~rawValue) & 0x3)
	}
}

extension Axes2D: ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = Bool

	public init(booleanLiteral value: Bool) {
		self = value ? .all : []
	}
}
