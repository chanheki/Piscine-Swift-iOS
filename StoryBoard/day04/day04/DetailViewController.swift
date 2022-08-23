//
//  DetailViewController.swift
//  day02
//
//  Created by Chan on 2022/08/18.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet var txtFd: UITextField!
	@IBOutlet var btnSet: UIButton!
	var receiveSubject = ""
	
	@IBOutlet weak var lblItem: UILabel!
	
	@IBAction func btnClicked(_ sender: Any) {
		
		guard let vc = self.storyboard?.instantiateViewController(identifier: "TableViewController") as? TableViewController else {
			print("error")
			return
		}
		print("vc created")
		let pid: Int = Int(txtFd.text!)!
//		vc.getUserName(project_id: pid)
		print(pid)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		lblItem.text = receiveSubject
	}
	
	func receiveSubject(_ subject: String) {
		receiveSubject = subject
	}
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}
