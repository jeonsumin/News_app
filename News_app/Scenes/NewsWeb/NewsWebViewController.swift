//
//  NewsWebViewController.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import UIKit
import WebKit
import SnapKit

class NewsWebViewController: UIViewController {
	private let webView = WKWebView()

	private let rightBarButtonItem = UIBarButtonItem(
		image: UIImage(systemName: "link"),
		style: .plain,
		target: self,
		action: #selector(didTapRightBarButtonItem) )
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupNavigationBar()
		setupWebView()
	}
}

private extension NewsWebViewController {
	func setupNavigationBar() {
		navigationItem.title = "기사 제목"
		navigationItem.rightBarButtonItem = rightBarButtonItem
	}

	func setupWebView() {
		guard let linkUrl = URL(string: "https://naver.com") else {
			navigationController?.popViewController(animated: true)
			return
		}

		view = webView
		let urlRequest = URLRequest(url: linkUrl)
		webView.load(urlRequest)
	}

	@objc func didTapRightBarButtonItem() {
		UIPasteboard.general.string = "뉴스 링크"
	}
}
