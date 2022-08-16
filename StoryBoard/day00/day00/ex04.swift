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
	
	var result = "0"
	var tempResult = 0
	var op = ""

	@IBAction func btnNumber(_ sender: UIButton) {
		if result == "0"{
			result = sender.currentTitle!
		} else {
			result += sender.currentTitle!
		}
		label.text = result
	}
	
	@IBAction func btnOper(_ sender: UIButton) {
		tempResult = Int(result)!
		result = "0"
		label.text = result
		op = sender.currentTitle!
	}
	
	@IBAction func btnResult(_ sender: Any) {
		switch op {
		case "/":
			if result != "0" {
				result = String(tempResult / Int(result)!)
			} else {
				result = "0"
			}
			label.text = result
		case "-":
			result = String(tempResult - Int(result)!)
			label.text = result
		case "+":
			result = String(tempResult + Int(result)!)
			label.text = result
		case "*":
			result = String(tempResult * Int(result)!)
			label.text = result
		default:
			break
		}
	}
	
	@IBAction func btnAC(_ sender: Any) {
		result = "0"
		tempResult = 0
		label.text = result
	}
	
	@IBAction func btnNEG(_ sender: Any) {
	}
	
}
