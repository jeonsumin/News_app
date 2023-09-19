//
//  MockNewsSearchManager.swift
//  News_appTests
//
//  Created by terry on 2023/09/19.
//

import Foundation
@testable import News_app

final class MockNewsSearchManager: NewsSearchManagerProtocol {
	var error: Error?
	var isCalledReqeust = false
	
	func request(from keyword: String, display: Int, start: Int, completionHandler: @escaping (([News_app.News]) -> Void)) {
		isCalledReqeust = true

		if error == nil {
			completionHandler([])
		}
	}
}
