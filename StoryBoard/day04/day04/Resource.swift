//
//  Resource.swift
//  day02
//
//  Created by Chan on 2022/08/18.
//

var names = ["Donald Pmurt", "Joffrey", "Ben"]
var date = ["8/18", "7/13", "9/13"]
var subject = ["no", "em", "tue"]



/*
// 42api
let appId = "628367b50670916b70f9c4a22c8599ea88c21c33101e5969b1f5db7585118b27"
let appSecret = "6eebf5e16486ad8bc69b34e827a3cf7c420ce7cb92db2c86444e540983c12a77"
let appRedirectUri = "https://chanhhh.tistory.com/category/IOS/Swift"
let apiUrl = URL(string: "https://api.intra.42.fr")
let apiTokenUrl = URL(string: "https://api.intra.42.fr/oauth/token")
var token: String?
var projectInfo: [Project] = []


func getToken() {
	let parameters = [
		"grant_type": "client_credentials",
		"client_id": appId,
		"client_secret": appSecret]
	
	let paramData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
	
	var request = URLRequest(url: apiTokenUrl!)
	request.httpMethod = "POST"
	request.httpBody = paramData
	
	request.addValue("application/json", forHTTPHeaderField: "Content-Type")
	request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
	
	let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
		guard let data = data, error == nil else {
			print("error=\(String(describing: error))")
			return
		}
		
		if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
			print("statusCode should be 200, but is \(httpStatus.statusCode)")
			print("response = \(String(describing: response))")
		}
		
		let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
		
		token = json!["access_token"] as! String
		print("token: ", token)
		sleep(3)
	}
	task.resume()
}

func getUserName(project_id: Int) {
	var info: [Project] = []
	if token == nil {
		print("token error: ", token, " end")
	}
	else {
		var pageIndex = 1
		repeat {
			print("Project start")
			print(pageIndex)
			let url = "https://api.intra.42.fr/v2/projects/\(project_id)/projects_users?filter[campus]=29&page[number]=\(pageIndex)"
			var request = URLRequest(url: URL(string: url)!)
			request.httpMethod = "GET"
			request.allHTTPHeaderFields = [
				"Authorization": "Bearer \(token!)"
			]
			
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				
				guard let data = data, error == nil else {
					print("task error: ", data, error, "end")
					return
				}
				
				if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
					print("statusCode should be 200, but is \(httpStatus.statusCode)")
					print("response = \(String(describing: response))")
				}
				
				info = try! JSONDecoder().decode([Project].self, from: data)
				projectInfo.append(contentsOf: info)
			}
			task.resume()
			pageIndex += 1
			sleep(1)
			//			} while (info.count != 0)
		} while (pageIndex != 2)
		print("Project finish")
		// 점수가 높은 순으로 프로젝트 유저 정렬
		projectInfo.sort { (Project1, Project2) -> Bool in
			return Project1.finalMark ?? 0 > Project2.finalMark ?? 0
		}
	}
	print(projectInfo.description)
}

*/
// MARK: - Project 42
struct Project: Codable {
	let id, occurrence, finalMark: Int?
	let status: String
	let project: ProjectClass
	let user: ProjectUser

	enum CodingKeys: String, CodingKey {
		case id, occurrence
		case finalMark = "final_mark"
		case status
		case project
		case user
	}
}

extension Project {
	public var description: String{
		return "\(user.login)"
	}
}


// MARK: - ProjectClass
struct ProjectClass: Codable {
	let id: Int
	let name, slug: String
	let parentID: JSONNull?

	enum CodingKeys: String, CodingKey {
		case id, name, slug
		case parentID = "parent_id"
	}
}

// MARK: - ProjectUser
struct ProjectUser: Codable {
	let id: Int
	let login: String
	let url: String
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}

	public var hashValue: Int {
		return 0
	}

	public init() {}

	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}
