//
//  ViewModel.swift
//  day06
//
//  Created by Chan on 2022/08/24.
//

import UIKit

enum Figure {
	case circle, square
	static let allFigures = [circle, square]
}

class Shape: UIView {
	private static let width = 100
	private static let height = 100
	static let size = CGSize(width: Shape.width, height: Shape.height)
	
	let figure = Figure.allFigures[Int(arc4random_uniform(UInt32(Figure.allFigures.count)))]
	
	let color = UIColor (
		red: (CGFloat(arc4random_uniform(100))/100),
		green: (CGFloat(arc4random_uniform(100))/100),
		blue: (CGFloat(arc4random_uniform(100))/100),
		alpha: 1.0
	)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		switch figure {
		case .circle:
			layer.cornerRadius = CGFloat(max(Shape.size.width, Shape.size.width) / 2)
		case .square:
			layer.cornerRadius = 0
//		default: break
		}
		backgroundColor = color
	}
	
	required init?(coder: NSCoder) {
		fatalError("error")
	}
}
