//
//  Shape.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-30.
//

import Foundation

public protocol Shape: Geometry3D {
	var body: Geometry3D { get }
}

public extension Shape {
	func generateOutput(environment: Environment) -> String {
		body.generateOutput(environment: environment)
	}
}


public protocol Shape2D: Geometry2D {
	var body: Geometry2D { get }
}

public extension Shape2D {
	func generateOutput(environment: Environment) -> String {
		body.generateOutput(environment: environment)
	}
}
