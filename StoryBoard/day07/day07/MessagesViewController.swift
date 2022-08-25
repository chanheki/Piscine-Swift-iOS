//
//  MessageViewController.swift
//  day07
//
//  Created by Chan on 2022/08/25.
//

import UIKit
import RecastAI
import ForecastIO
import CoreLocation
import JSQMessagesViewController

class MessagesViewController: JSQMessagesViewController {
	
	var recastClient: RecastAIClient?
	var darkSkyClient: DarkSkyClient?
	
	var users: [User] = [
		User(id: "0", name: "Siri"),
		User(id: "1", name: "Chanheki")]
	
	var messages: [JSQMessage] = [JSQMessage(
		senderId: "0",
		displayName: "Siri",
		text: "Weather in which city are you interested in?"
	)] {
		didSet {
			DispatchQueue.main.async {
				if self.messages.last!.senderId == self.users.first?.id {
					self.finishSendingMessage()
				}
			}
		}
	}
	
	var locationCoordinates: CLLocationCoordinate2D? {
		didSet {
			getForcastFromDarkSky()
		}
	}
	
	var error: String? {
		didSet {
			let message = JSQMessage(
				senderId: users.first!.id,
				displayName: users.first!.name,
				text: error!)

			messages.append(message!)
			finishSendingMessage()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.recastClient = RecastAIClient(token : "", language: "en")
		self.darkSkyClient = DarkSkyClient(apiKey: "")
		darkSkyClient?.units = .si
		darkSkyClient?.language = .korean
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
		return NSAttributedString(string: messages[indexPath.row].senderDisplayName)
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
		return 16
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
		return nil
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource? {
		let bubbleFactory = JSQMessagesBubbleImageFactory()

		if messages[indexPath.row].senderId != users.first?.id {
			return bubbleFactory!.outgoingMessagesBubbleImage(with: .orange)
		} else {
			return bubbleFactory!.incomingMessagesBubbleImage(with: .gray)
		}
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
		return messages[indexPath.row]
	}

	override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
		let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)

		messages.append(message!)
		finishSendingMessage()
		make(request: text)
	}

	override func senderId() -> String {
		return users.last!.id
	}

	override func senderDisplayName() -> String {
		return users.last!.name
	}

	func make(request: String){
		recastClient?.textRequest(request, successHandler: { (response) in
			if let locations = response.all(entity: "location") {
				let coordinates = (locations[0]["formatted"] as? String, locations[0]["lat"]?.doubleValue, locations[0]["lng"]?.doubleValue)
				self.locationCoordinates = CLLocationCoordinate2D(
					latitude: coordinates.1!,
					longitude: coordinates.2!
				)
			} else {
				self.error = "Enter a valid city and try again!"
			}
		}, failureHandle: { (error) in
			self.error = "An error occurred, please try again!"
		})
	}

	func getForcastFromDarkSky() {
		if locationCoordinates != nil {
			darkSkyClient?.getForecast(location: locationCoordinates!) { result in
				switch result {
					case .success((let currentForecast, _)):
						let message = JSQMessage(
							senderId: self.users.first!.id,
							displayName: self.users.first!.name,
							text: "The wether is \(currentForecast.currently!.summary!) and the temperature is \(currentForecast.currently!.temperature!) C")

						self.messages.append(message!)
					case .failure:
						self.error = "ERROR"
				}
			}
		}
	}
}
