//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-05.
//

import Foundation

extension Geometry3D {
	public func `repeat`(along axis: Axis3D, in range: Range<Double>, step: Double) -> Geometry3D {
		let strideBy = stride(from: range.lowerBound, to: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.translate(Vector3D.zero.setting(axes: Axes3D(axis: axis), to: value))
		}
	}

	public func `repeat`(along axis: Axis3D, in range: ClosedRange<Double>, count: Int) -> Geometry3D {
		let step = (range.upperBound - range.lowerBound) / Double(count - 1)
		let strideBy = stride(from: range.lowerBound, through: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.translate(Vector3D.zero.setting(axes: Axes3D(axis: axis), to: value))
		}
	}

	public func `repeat`(around axis: Axis3D, in range: Range<Angle>, step: Angle) -> Geometry3D {
		let strideBy = stride(from: range.lowerBound, to: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.rotate(angle: value, axis: axis)
		}
	}

	public func `repeat`(around axis: Axis3D, in range: ClosedRange<Angle>, count: Int) -> Geometry3D {
		let step = (range.upperBound - range.lowerBound) / Double(count - 1)
		let strideBy = stride(from: range.lowerBound, through: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.rotate(angle: value, axis: axis)
		}
	}

	public func distibute(along axis: Axis3D, translations: [Double]) -> Geometry3D {
		ForEach(translations) { offset in
			self.translate(Vector3D.zero.setting(axes: Axes3D(axis: axis), to: offset))
		}
	}
}


extension Geometry2D {
	public func `repeat`(along axis: Axis2D, in range: Range<Double>, step: Double) -> Geometry2D {
		let strideBy = stride(from: range.lowerBound, to: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.translate(Vector2D.zero.setting(axes: Axes2D(axis: axis), to: value))
		}
	}

	public func `repeat`(along axis: Axis2D, in range: ClosedRange<Double>, count: Int) -> Geometry2D {
		let step = (range.upperBound - range.lowerBound) / Double(count - 1)
		let strideBy = stride(from: range.lowerBound, through: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.translate(Vector2D.zero.setting(axes: Axes2D(axis: axis), to: value))
		}
	}

	public func `repeat`(in range: Range<Angle>, step: Angle) -> Geometry2D {
		let strideBy = stride(from: range.lowerBound, to: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.rotate(value)
		}
	}

	public func `repeat`(in range: ClosedRange<Angle>, count: Int) -> Geometry2D {
		let step = (range.upperBound - range.lowerBound) / Double(count - 1)
		let strideBy = stride(from: range.lowerBound, through: range.upperBound, by: step)
		return ForEach(strideBy) { value in
			self.rotate(value)
		}
	}
}

