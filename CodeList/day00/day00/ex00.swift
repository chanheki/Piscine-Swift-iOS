//
//  ex00.swift
//  day00
//
//  Created by Chan on 2022/08/16.
//

import UIKit

class ex00: UIViewController {
	let WIDTH : CGFloat = 70
	let HEIGHT : CGFloat = 50
	
	var btn = UIButton()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		btnInit(btn, title: "Click me", width: WIDTH, height: HEIGHT, top: 380, leading: 120)
	}
	
	func btnInit(_ sender: UIButton, title: String, width: CGFloat, height: CGFloat, top: CGFloat, leading: CGFloat) {
		self.view.addSubview(sender)
		
		sender.translatesAutoresizingMaskIntoConstraints = false
		
		sender.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//		sender.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
		
		sender.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top).isActive = true
		sender.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: leading).isActive = true
		
		sender.widthAnchor.constraint(equalToConstant: width).isActive = true
		sender.heightAnchor.constraint(equalToConstant: height).isActive = true
		
		sender.setTitle(title, for: .normal)
		sender.setTitleColor(.black, for: .normal)
//		sender.backgroundColor = .orange
		
		sender.addTarget(self, action: #selector(onClick), for: .touchUpInside)
	}
	
	@objc func onClick(_ button: UIButton) {
		print("Hello World!")
	}
}
