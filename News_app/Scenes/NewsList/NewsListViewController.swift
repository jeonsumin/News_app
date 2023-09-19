//
//  NewsListViewController.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import UIKit
import SnapKit

class NewsListViewController: UIViewController {

    private lazy var presenter = NewsListPresenter(viewController: self)

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)

        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.register(NewsListTableViewCell.self,
                           forCellReuseIdentifier: NewsListTableViewCell.identifier)
        tableView.register(NewsListTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: NewsListTableViewHeaderView.identifier)

        tableView.refreshControl = refreshControl

        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationbar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupViwes() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}
