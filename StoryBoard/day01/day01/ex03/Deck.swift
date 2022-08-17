
//  Deck.swift
//  day01
//
//  Created by Chan on 2022/08/17.
//

import Foundation

class Deck: NSObject {
	static let allSpades: [Card] = Value.allValues.map({Card(.spade, $0)})
	static let allDiamonds: [Card] = Value.allValues.map({Card(.diamond, $0)})
	static let allHearts: [Card] = Value.allValues.map({Card(.heart, $0)})
	static let allClubs: [Card] = Value.allValues.map({Card(.club, $0)})
	
	static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
	mutating func randomTable() {
		for i in self.indices {
			let newIndex = Int(arc4random_uniform(UInt32(self.count - 1)))
			swapAt(newIndex, i)
		}
	}
}

