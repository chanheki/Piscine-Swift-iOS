//
//  TableViewController.swift
//  day02
//
//  Created by Chan on 2022/08/18.
//

import UIKit

class TableViewController: UITableViewController {
	
	@IBOutlet var tableViewPeople: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.leftBarButtonItem = self.editButtonItem	// edit 버튼
	}
	
	override func viewWillAppear(_ animated: Bool) {
		tableViewPeople.reloadData()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return names.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
		var content = cell.defaultContentConfiguration()
		
		content.text = names[indexPath.row]
		content.text! += "   \(date[indexPath.row])"
		content.secondaryText = subject[indexPath.row]
		cell.contentConfiguration = content
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			names.remove(at: (indexPath as NSIndexPath).row)
			date.remove(at: (indexPath as NSIndexPath).row)
			subject.remove(at: (indexPath as NSIndexPath).row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "삭제"
	}
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		let namesToMove = names[(fromIndexPath as NSIndexPath).row]
		let datesToMove = date[(fromIndexPath as NSIndexPath).row]
		let subjectToMove = subject[(fromIndexPath as NSIndexPath).row]
		
		names.remove(at: (fromIndexPath as NSIndexPath).row)
		date.remove(at: (fromIndexPath as NSIndexPath).row)
		subject.remove(at: (fromIndexPath as NSIndexPath).row)
		names.insert(namesToMove, at: (to as NSIndexPath).row)
		date.insert(datesToMove, at: (to as NSIndexPath).row)
		subject.insert(subjectToMove, at: (to as NSIndexPath).row)
	}
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		if segue.identifier == "sgDetail" {
			let cell = sender as! UITableViewCell
			let indexPath = tableViewPeople.indexPath(for: cell)
			let detailView = segue.destination as! DetailViewController
			detailView.receiveSubject(subject[((indexPath as NSIndexPath?)?.row)!])
		}
	}
	
}
