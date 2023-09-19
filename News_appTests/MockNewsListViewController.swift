//
//  MockNewsListViewController.swift
//  News_appTests
//
//  Created by terry on 2023/09/19.
//

import Foundation
@testable import News_app

final class MockNewsListViewController: NewsListProtocol {
	var isCalledSetupnavigationBar = false
	var isCalledSetupViwes = false
	var isCalledEndRefreshing = false
	var isCalledMoveToNewsWebViewController = false
	var isCalledReloadTableView = false
	func setupNavigationbar() {
		isCalledSetupnavigationBar = true
	}

	func setupViwes() {
		isCalledSetupViwes = true
	}

	func endRefreshing() {
		isCalledEndRefreshing = true
	}

	func moveToNewsWebViewController(with news: News_app.News) {
		isCalledMoveToNewsWebViewController = true
	}

	func reloadTableView() {
		isCalledReloadTableView = true
	}
}
