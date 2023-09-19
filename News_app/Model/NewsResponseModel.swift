//
//  NewsResponseModel.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import Foundation

struct NewsResponseModel: Decodable {
	var items: [News] = []
}

struct News: Decodable {
	let title: String
	let link: String
	let description: String
	let pubDate: String 
}

