//
//  AddViewController.swift
//  day02
//
//  Created by Chan on 2022/08/18.
//

import UIKit

class AddViewController: UIViewController {

	
	@IBOutlet weak var addPersonTextfield: UITextField!
	@IBOutlet weak var addDate: UIDatePicker!
	@IBOutlet weak var addSubject: UITextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
    }
    
	@IBAction func addBtn(_ sender: Any) {
		names.append(addPersonTextfield.text ?? "name")
		date.append(addDate.date.ISO8601Format())
		subject.append(addSubject.text)
		_ = navigationController?.popViewController(animated: true)
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
