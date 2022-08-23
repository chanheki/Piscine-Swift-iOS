//
//  APITwitterDelegate.swift
//  day04
//
//  Created by Chan on 2022/08/22.
//

import Foundation

protocol APITwitterDelegate: AnyObject{
	func apiTwitter (tweets: [Tweet])
	func error(error: NSError)
}
