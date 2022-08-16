//
//  ex02.swift
//  day00
//
//  Created by Chan on 2022/08/16.
//

import UIKit

class ex02: UIViewController {

	let WIDTH: CGFloat = 30
	let HEIGHT: CGFloat = 50

	var btn1 = UIButton()
	var btn2 = UIButton()
	var btn3 = UIButton()
	var btn4 = UIButton()
	var btn5 = UIButton()
	var btn6 = UIButton()
	var btn7 = UIButton()
	var btn8 = UIButton()
	var btn9 = UIButton()
	var btn0 = UIButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		// Do any additional setup after loading the view.
		btnInit(btn1, title: "1", width: WIDTH, height: HEIGHT, top: 100, leading: 10)
		btnInit(btn2, title: "2", width: WIDTH, height: HEIGHT, top: 100, leading: 120)
		btnInit(btn3, title: "3", width: WIDTH, height: HEIGHT, top: 100, leading: 230)
		btnInit(btn4, title: "4", width: WIDTH, height: HEIGHT, top: 160, leading: 10)
		btnInit(btn5, title: "5", width: WIDTH, height: HEIGHT, top: 160, leading: 120)
		btnInit(btn6, title: "6", width: WIDTH, height: HEIGHT, top: 160, leading: 230)
		btnInit(btn7, title: "7", width: WIDTH, height: HEIGHT, top: 220, leading: 10)
		btnInit(btn8, title: "8", width: WIDTH, height: HEIGHT, top: 220, leading: 120)
		btnInit(btn9, title: "9", width: WIDTH, height: HEIGHT, top: 220, leading: 230)
		btnInit(btn0, title: "0", width: WIDTH, height: HEIGHT, top: 380, leading: 120)
		
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
		sender.backgroundColor = .orange
		
		sender.addTarget(self, action: #selector(onClick), for: .touchUpInside)
	}
	
	@objc func onClick(_ button: UIButton) {
		switch button {
		case btn1 :
			print("1")
		case btn2 :
			print("2")
		case btn3 :
			print("3")
		case btn4 :
			print("4")
		case btn5 :
			print("5")
		case btn6 :
			print("6")
		case btn7 :
			print("7")
		case btn8 :
			print("8")
		case btn9 :
			print("9")
		case btn0 :
			print("0")
			
		default :
			break

		}
	}
	@IBAction func helloWorldButton(_ sender: Any) {
		print("Hello World !")
	}
	
}

