//
//  ViewController.swift
//  day00
//
//  Created by Chan on 2022/08/16.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	
	@IBOutlet weak var label:UILabel!
	
	@IBAction func clickMe(_ sender: Any) {
		print("Hello World!")
	}
}

