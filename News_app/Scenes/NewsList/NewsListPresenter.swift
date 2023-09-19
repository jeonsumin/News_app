//
//  NewsListPresenter.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import UIKit

protocol NewsListProtocol: AnyObject {
	func setupNavigationbar()
	func setupViwes()
	func endRefreshing()
	func moveToNewsWebViewController(with news: News)
	func reloadTableView()
}

class NewsListPresenter: NSObject {
	private weak var viewController: NewsListProtocol?
	private let newsSearchManager: NewsSearchManagerProtocol

	private var newsList: [News] = []
	private var currentKeyword = ""
	private let tags: [String] = ["IT", "아이폰", "개발", "경제", "연예", "사회", "정치"]
	// 지금까지 Request된, 가지고 있는 보여주고 있는 page가 어딘지
	private var currentPage: Int = 0

	// 한 페이지에 최대 몇 개 까지 보여줄건지
	private let display: Int = 20


	init(viewController: NewsListProtocol,
		 newsSearchManger: NewsSearchManagerProtocol = NewsSearchManager()) {
		self.viewController = viewController
		self.newsSearchManager = newsSearchManger
	}

	func viewDidLoad() {
		viewController?.setupNavigationbar()
		viewController?.setupViwes()
	}

	func didCalledRefresh() {
		requestNewsList(isNeededToReset: true)
	}
}

extension NewsListPresenter: NewsListTableViewViewHeaderViewDelegate {
	func didSelectedTag(_ selectedIndex: Int) {
		currentKeyword = tags[selectedIndex]
		requestNewsList(isNeededToReset: true)
	}
}

extension NewsListPresenter: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewController?.moveToNewsWebViewController(with: newsList[indexPath.row])
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let currentRow = indexPath.row

		guard (currentRow % 20) == display - 3 && (currentRow / display ) == (currentPage - 1) else {
			return
		}

		requestNewsList(isNeededToReset: false)
	}
}
extension NewsListPresenter: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return newsList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier,
													   for: indexPath) as? NewsListTableViewCell
		else { return UITableViewCell() }
		let news = newsList[indexPath.row]
		cell.setup(news: news)
		cell.selectionStyle = .none

		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableViewHeaderView.identifier) as? NewsListTableViewHeaderView
		else { return UIView() }
		header.setup(tags: tags, delegate: self)
		return header
	}
}
private extension NewsListPresenter {
	func requestNewsList(isNeededToReset: Bool) {
		if isNeededToReset {
			currentPage = 0
			newsList = []
		}

		newsSearchManager.request(
			from: currentKeyword,
			display: display,
			start: (currentPage * display) + 1) {[weak self] newValue in
				self?.newsList += newValue
				self?.currentPage += 1
				self?.viewController?.reloadTableView()
				self?.viewController?.endRefreshing()
			}
	}
}
