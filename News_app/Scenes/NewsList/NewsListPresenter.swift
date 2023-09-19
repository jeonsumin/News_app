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
	func moveToNewsWebViewController()
}

class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?

    init(viewController: NewsListProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController?.setupNavigationbar()
        viewController?.setupViwes()
    }

    func didCalledRefresh() {
        viewController?.endRefreshing()
    }
}

extension NewsListPresenter: UITableViewDelegate {}
extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier,
                                                       for: indexPath) as? NewsListTableViewCell
        else { return UITableViewCell() }
        cell.setup()
        cell.selectionStyle = .none

        return cell
    }
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewController?.moveToNewsWebViewController()
	}

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableViewHeaderView.identifier) as? NewsListTableViewHeaderView else { return UIView() }
        header.setup()
        return header
    }
}
