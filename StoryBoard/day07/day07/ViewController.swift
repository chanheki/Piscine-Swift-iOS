//
//  ViewController.swift
//  day07
//
//  Created by Chan on 2022/08/25.
//

import UIKit
import RecastAI
import ForecastIO
import CoreLocation

class ViewController: UIViewController {
	
	var recastClient : RecastAIClient?
	var darkSkyClient: DarkSkyClient?
	
	@IBOutlet var recastAILabel: UILabel!
	@IBOutlet var recastAITF: UITextField!
	@IBAction func sendButton(_ sender: UIButton) {
		makeRequest()
		print(recastAITF.text ?? "")
	}
	
	var locationCoordinates: CLLocationCoordinate2D? {
		didSet {
			getForcastFromDarkSky()
		}
	}
	
	var forcastText: String = "Enter city" {
		didSet {
			DispatchQueue.main.async {
				self.recastAILabel.text = self.forcastText
			}
		}
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.recastClient = RecastAIClient(token : "", language: "en")
		self.darkSkyClient = DarkSkyClient(apiKey: "")
		darkSkyClient?.units = .si
		darkSkyClient?.language = .korean
	}
	/**
	Make text request to Recast.AI API
	*/
	func makeRequest()
	{
		//Call makeRequest with string parameter to make a text request
		self.recastClient?.textRequest(
			recastAITF.text ?? "",
			successHandler: recastSuccess,
			failureHandle: recastFailure)
	}
	
	func recastSuccess (_ response: Response) -> () {
		if let locations = response.all(entity: "location") {
			let coordinates = (locations[0]["formatted"] as? String, locations[0]["lat"]?.doubleValue, locations[0]["lng"]?.doubleValue)
			//self.answerLabel.text = "\(coordinates.0!)\nLAT: \(coordinates.1!)\nLNG:\(coordinates.2!)"

			self.locationCoordinates = CLLocationCoordinate2D(
				latitude: coordinates.1!,
				longitude: coordinates.2!
			)
		} else {
			self.recastAILabel.text = "Enter a valid city"
		}
		
	}
	
	func recastFailure (_ error: Error) -> () {
		self.recastAILabel.text = "Error"
	}



	func getForcastFromDarkSky() {
		if locationCoordinates != nil {
			darkSkyClient?.getForecast(location: locationCoordinates!) { result in
				switch result {
				case .success((let currentForecast, _)):
					self.forcastText =
					currentForecast.currently?.summary?.description ?? "sma"
				case .failure:
					self.forcastText = "ERROR"
				}
			}
		}
	}
}

