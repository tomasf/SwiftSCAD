//
//  Shape.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-30.
//

import Foundation

protocol Shape: Geometry3D {
	var body: Geometry3D { get }
}

extension Shape {
	func generateOutput(environment: Environment) -> String {
		body.generateOutput(environment: environment)
	}
}


protocol Shape2D: Geometry2D {
	var body: Geometry2D { get }
}

extension Shape2D {
	func generateOutput(environment: Environment) -> String {
		body.generateOutput(environment: environment)
	}
}
