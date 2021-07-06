import Foundation

@_functionBuilder public struct UnionBuilder {
	public static func buildBlock(_ children: Geometry3D...) -> Geometry3D {
		if children.count > 1 {
			return Union3D(children: children)
		} else {
			return children[0]
		}
	}

	public static func buildIf(_ children: Geometry3D?...) -> Geometry3D {
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

	public static func buildIf(_ children: Geometry2D?...) -> Geometry2D {
		if children.count > 1 {
			return Union2D(children: children.compactMap { $0 })
		} else {
			return children[0] ?? Empty()
		}
	}
}
