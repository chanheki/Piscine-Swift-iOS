//
//  ex01.swift
//  day00
//
//  Created by Chan on 2022/08/16.
//

import UIKit

class ex01: UIViewController {
	let label1: UILabel = {
		let label1 = UILabel()
		
		label1.text = "Hello World!"
		label1.translatesAutoresizingMaskIntoConstraints = false
		label1.textColor = .red
		return label1
	}()

	let btn: UIButton = {
		let button = UIButton()

		button.setTitle("Button", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}()
	
	let stackView: UIStackView = {
		let stackView = UIStackView()
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		
		return stackView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		self.view.addSubview(stackView)
		[label1, btn].map {
			self.stackView.addArrangedSubview($0)
			$0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true
		}
		stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
	}

	@objc func onClick(_ button: UIButton) {
		print("Hello World!")
	}
}
