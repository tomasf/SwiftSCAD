//
//  Save.swift
//  GeometryGenerator
//
//  Created by Tomas Franzén on 2021-06-29.
//

import Foundation

public func Output(to path: String, @UnionBuilder body: () -> Geometry3D) {
	let fullPath = (path as NSString).expandingTildeInPath
	let output = body().generateOutput(environment: Environment())
	do {
		try output.write(toFile: fullPath, atomically: false, encoding: .utf8)
	} catch {
		preconditionFailure("Failed to write to file \(fullPath)")
	}
}
