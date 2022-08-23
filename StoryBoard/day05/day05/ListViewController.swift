//
//  ListTableViewController.swift
//  day05
//
//  Created by Chan on 2022/08/23.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet var listTable: UITableView!
	let cellIdentifier = "cell"
	let listItems = ["42", "Saint Ouen", "Grenoble", "Reims", "Moldavie", "Circuit"]
	let ItemsCoor: [[String]] = [["37.4882145", "127.0647887"], ["35.6646191", "139.7377873"], ["48.896607", "2.318501"], ["55.79714", "37.57983"], ["45.77966", "4.75065"], ["35.6646191", "2.318501"]]
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		listTable.reloadData()
	}

	// MARK: - Table view data source
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("numberOfRowsInSection")
		return listItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
		var content = cell.defaultContentConfiguration()
		
		content.text = listItems[indexPath.row]
		cell.contentConfiguration = content
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		currentCoorLatitude = ItemsCoor[indexPath.row][0]
		currentCoorLongitude = ItemsCoor[indexPath.row][1]
		print(currentCoorLatitude, currentCoorLongitude)
		
		performSegue(withIdentifier: "unwindMap", sender: self)
	}
}
