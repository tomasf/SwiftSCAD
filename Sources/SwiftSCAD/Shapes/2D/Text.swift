//
//  File.swift
//  
//
//  Created by Tomas Franzén on 2021-07-05.
//

import Foundation

public struct Text: Geometry2D {
	let text: String
	let font: Font
	let horizontalAlignment: HorizontalAlignment
	let verticalAlignment: VerticalAlignment
	let characterSpacingFactor: Double

	public init(_ text: String, font: Font, alignment: (HorizontalAlignment, VerticalAlignment) = (.left, .baseline), spacingFactor: Double = 1) {
		self.text = text
		self.font = font
		(self.horizontalAlignment, self.verticalAlignment) = alignment
		self.characterSpacingFactor = spacingFactor
	}

	public func generateOutput(environment: Environment) -> String {
		let params: [String: ScadFormattable] = [
			"text": text,
			"size": font.size,
			"font": font.fontString,
			"halign": horizontalAlignment.rawValue,
			"valign": verticalAlignment.rawValue,
			"spacing": characterSpacingFactor
		]
		let paramText = params
			.sorted(by: { a, b in a.key < b.key })
			.map { key, value in "\(key)=\(value.scadString)"}.joined(separator: ", ")
		return "text(\(paramText));"
	}

	public struct Font {
		public let name: String
		public let size: Double
		public let style: String?

		public init(name: String, size: Double, style: String? = nil) {
			self.name = name
			self.size = size
			self.style = style
		}

		fileprivate var fontString: String {
			if let style = style {
				return name + ":style=" + style
			} else {
				return name
			}
		}
	}

	public enum HorizontalAlignment: String {
		case left
		case center
		case right
	}

	public enum VerticalAlignment: String {
		case top
		case center
		case baseline
		case bottom
	}
}
