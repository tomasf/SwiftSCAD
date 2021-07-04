//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-04.
//

import Foundation

fileprivate func saveToFile(string: String, to path: String) {
	let fullPath = (path as NSString).expandingTildeInPath
	do {
		try string.write(toFile: fullPath, atomically: false, encoding: .utf8)
	} catch {
		preconditionFailure("Failed to write to file \(fullPath)")
	}
}

public extension Geometry3D {
	@discardableResult func save(to path: String) -> Geometry3D {
		saveToFile(string: generateOutput(environment: Environment()), to: path)
		return self
	}
}

public extension Geometry2D {
	@discardableResult func save(to path: String) -> Geometry2D {
		saveToFile(string: generateOutput(environment: Environment()), to: path)
		return self
	}
}
