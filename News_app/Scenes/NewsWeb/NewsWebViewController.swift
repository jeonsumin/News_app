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
	private let news: News

	private let rightBarButtonItem = UIBarButtonItem(
		image: UIImage(systemName: "link"),
		style: .plain,
		target: self,
		action: #selector(didTapRightBarButtonItem) )

	init(news: News){
		self.news = news
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupNavigationBar()
		setupWebView()
	}
}

private extension NewsWebViewController {
	func setupNavigationBar() {
		navigationItem.title = news.title.htmlToString
		navigationItem.rightBarButtonItem = rightBarButtonItem
	}

	func setupWebView() {
		guard let linkUrl = URL(string: news.link) else {
			navigationController?.popViewController(animated: true)
			return
		}

		view = webView
		let urlRequest = URLRequest(url: linkUrl)
		webView.load(urlRequest)
	}

	@objc func didTapRightBarButtonItem() {
		UIPasteboard.general.string = news.link
	}
}
