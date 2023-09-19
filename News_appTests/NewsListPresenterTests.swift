//
//  NewsListPresenterTests.swift
//  News_appTests
//
//  Created by deepvisions on 2023/09/19.
//

import XCTest
@testable import News_app

class NewsListPresenterTests: XCTestCase {
	var sut: NewsListPresenter!

	var viewController: MockNewsListViewController!
	var newsSearchManager: MockNewsSearchManager!

	override func setUp() {
		super.setUp()

		viewController = MockNewsListViewController()
		newsSearchManager = MockNewsSearchManager()

		sut = NewsListPresenter(viewController: viewController,newsSearchManger: newsSearchManager)
	}

	override func tearDown() {
		sut = nil
		newsSearchManager = nil
		viewController = nil
	}

	func test_viewDidLoad가_요청될때() {
		sut.viewDidLoad()

		XCTAssertTrue(viewController.isCalledSetupnavigationBar)
		XCTAssertTrue(viewController.isCalledSetupViwes)
	}

	func test_didCalledRefresh가_요청될때_reqeustdp_실패하면() {
		newsSearchManager.error = NSError() as Error
		sut.didCalledRefresh()
		XCTAssertFalse(viewController.isCalledReloadTableView)
		XCTAssertFalse(viewController.isCalledEndRefreshing)
	}

	func test_didCalledRefresh가_요청될때_reqeustdp_성공하면() {
		sut.didCalledRefresh()
		newsSearchManager.error = nil
		XCTAssertTrue(viewController.isCalledReloadTableView)
		XCTAssertTrue(viewController.isCalledEndRefreshing)
	}
}
