//
//  NewsListTableViewCell.swift
//  News_app
//
//  Created by deepvisions on 2023/09/19.
//

import UIKit
import SnapKit

class NewsListTableViewCell: UITableViewCell {

    static let identifier = "NewsListTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    func setup(){
        setupLayout()

        accessoryType = .disclosureIndicator
        titleLabel.text = "기사 제목"
        descriptionLabel.text = "기사 내용"
        dateLabel.text = "2023.01.01"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewsListTableViewCell {
    func setupLayout() {
        
        
        [titleLabel, descriptionLabel, dateLabel].forEach {
            addSubview($0)
        }
        let superViewInset: CGFloat = 16.0
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(48)
        }
        let verticalSpacing: CGFloat = 4.0
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }

    }
}
