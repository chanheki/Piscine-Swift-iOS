//
//  ViewController.swift
//  day00
//
//  Created by Chan on 2022/08/16.
//

import UIKit

class ViewController: UIViewController {
	
	let WIDTH : CGFloat = 70
	let HEIGHT : CGFloat = 50
	
	var btn = UIButton()
	var btn1 = UIButton()
	var btn2 = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		btnInit(btn, title: "ex00", width: WIDTH, height: HEIGHT, top: 100, leading: 120, move: #selector(moveToEx00))
		btnInit(btn1, title: "ex01", width: WIDTH, height: HEIGHT, top: 200, leading: 120, move: #selector(moveToEx01))
		btnInit(btn2, title: "ex02", width: WIDTH, height: HEIGHT, top: 300, leading: 120, move: #selector(moveToEx02))
	}
	
	func btnInit(_ sender: UIButton, title: String, width: CGFloat, height: CGFloat, top: CGFloat, leading: CGFloat, move: Selector) {
		self.view.addSubview(sender)
//		sender.backgroundColor = .red
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
		
		sender.addTarget(self, action: move, for: .touchUpInside)
	}
	
	@objc func moveToEx00(_ button: UIButton) {
		let viewController = ex00()
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	@objc func moveToEx01(_ button: UIButton) {
		let viewController = ex01()
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	@objc func moveToEx02(_ button: UIButton) {
		let viewController = ex02()
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}


