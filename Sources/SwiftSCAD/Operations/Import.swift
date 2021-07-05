//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-04.
//

import Foundation

public struct Import3D: Geometry3D {
	let path: String

	public init(path: String) {
		self.path = path
	}

	public func scadString(environment: Environment) -> String {
		"import(\(path.scadString));"
	}
}

public struct Import2D: Geometry2D {
	let path: String

	public init(path: String) {
		self.path = path
	}

	public func scadString(environment: Environment) -> String {
		"import(\(path.scadString));"
	}
}
