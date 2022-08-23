//
//  Token.swift
//  day04
//
//  Created by Chan on 2022/08/22.
//

import Foundation

struct Token: Codable {
	var access_token: String
	var token_type: String
	var expires_in: String
	var scope: String
	var created_at: String
}

struct Tweet: CustomStringConvertible{
	let name: String?
	let date: String?
	let text: String?
	
	var description: String {
		return ("Name: \(name)\nDate:date\nText: \(text)")
	}
}

struct OAuth{
	private let apiKey = ""
	private let apiSecret = ""
	
	private let apiBearer: String
	
	init() {
		apiBearer = (apiKey + ":" + apiSecret)
			.data(using: String.Encoding.utf8)!
			.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
	}
	
	private func prepareOAuchRequest() -> URLRequest {
		let url = URL(string: "https://api.twitter.com/oauth2/token")
		var request = URLRequest(url: url!)
		
		request.httpMethod = "POST"
		request.setValue("Basic \(apiBearer)", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
		request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)

		return request
	}
	
	private func sendOAuchRequest(request: URLRequest) -> String? {
		var token: String?

		let auchRequest = URLSession.shared.dataTask(with: request) { (data, response, error) in
			if error != nil {
				print(error ?? "OAUCH REQUEST ERROR")
			} else if data != nil {
				do {
					if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
						token = dic.value(forKey: "access_token") as? String
					}
				}
				catch (let error) {
					print(error)
				}
			}
		}
		auchRequest.resume()
		sleep(1)

		return token
	}

	func getToken() -> String {
		let request: URLRequest = prepareOAuchRequest()
		var token: String?
		var retry: Int = 0

		while token == nil || retry > 10 {
			token = sendOAuchRequest(request: request)
			retry += 1
		}

		return token ?? "TokenWasNotReceived"
	}
}
