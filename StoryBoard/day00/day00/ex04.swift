//
//  ex04.swift
//  day00
//
//  Created by Chan on 2022/08/16.
//

import UIKit

class ex04: UIViewController {
	
	@IBOutlet weak var label: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	var number = [Int]()
	var operation = [String]()
	var result = 0
	var screen = ""
	@IBAction func btnNumber(_ sender: UIButton) {
		if screen.isEmpty {
			screen = sender.currentTitle!
		} else {
			screen += sender.currentTitle!
		}
		label.text = screen
	}
	
	@IBAction func btnOper(_ sender: UIButton) {
		number.append(Int(label.text!)!)
		operation.append(sender.currentTitle!)
		
		screen = ""
	}
	
	@IBAction func btnResult() {
		number.append(Int(label.text!)!)
//		print(number, operation)
		for (i, v) in operation.enumerated() {
			if v == "*" {
				number[i] = number[i] * number[i+1]
				number.remove(at: i+1)
				operation.remove(at: i)
			} else if v == "/" {
				number[i] = number[i] / number[i+1]
				number.remove(at: i+1)
				operation.remove(at: i)
			}
		}
		for (i, v) in operation.enumerated() {
			if v == "+" {
				number[i] = number[i] + number[i+1]
				number.remove(at: i+1)
				operation.remove(at: i)
			} else {
				number[i] = number[i] - number[i+1]
				number.remove(at: i+1)
				operation.remove(at: i)
			}
		}
		label.text = String(number[0])
		number.removeAll()
		screen = ""
	}
	
	@IBAction func btnAC(_ sender: Any) {
		number.removeAll()
		operation.removeAll()
		screen = ""
		label.text = "0"
	}
	
	@IBAction func btnNEG(_ sender: Any) {
		label.text = String(Int(label.text!)! * -1)
		screen = label.text!
	}
	
}
