//
//  File.swift
//  day01
//
//  Created by Chan on 2022/08/17.
//

import Foundation


class Card: NSObject {
	var color: Color
	var value: Value
	override var description: String { "(\(color), \(value))" }
	
	init(_ color: Color, _ value: Value) {
		self.color = color
		self.value = value
	}
	
	override func isEqual(to object: Any?) -> Bool {
		let obj: Card = object as! Card
		if self.color == obj.color && self.value == obj.value {
			return true
		} else {
			return false
		}
	}
	
	static func == (lhs: Card, rhs: Card) -> Bool {
		return lhs.isEqual(to: rhs)
	}
}

