//
//  NewsListTableViewHeaderView.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import UIKit
import TTGTags
import SnapKit
protocol NewsListTableViewViewHeaderViewDelegate:AnyObject {
	func didSelectedTag(_ selectedIndex: Int)
}
class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
	static let identifier = "NewsListTableViewHeaderView"
	private var tags: [String] = []

	private lazy var tagCollectionView = TTGTextTagCollectionView()
	private weak var delegate: NewsListTableViewViewHeaderViewDelegate?

	func setup(tags: [String], delegate: NewsListTableViewViewHeaderViewDelegate) {
		self.delegate = delegate
		self.tags = tags

		contentView.backgroundColor = .systemBackground

		setupTagCollectionViewLayout()
		setupTagCollectionView()
	}
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
	func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
		guard tag.selected else { return }
		delegate?.didSelectedTag(Int(index))
	}
}
private extension NewsListTableViewHeaderView {
	func setupTagCollectionViewLayout() {
		addSubview(tagCollectionView)

		tagCollectionView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}

	func setupTagCollectionView() {
		tagCollectionView.delegate = self
		tagCollectionView.numberOfLines = 1
		tagCollectionView.scrollDirection = .horizontal
		tagCollectionView.selectionLimit = 1

		tagCollectionView.showsHorizontalScrollIndicator = false
		let insetValue: CGFloat = 16.0
		tagCollectionView.contentInset = UIEdgeInsets(top: insetValue,
													  left: insetValue,
													  bottom: insetValue,
													  right: insetValue)

		let cornerRadiusValue: CGFloat = 12.0
		let shadowOpacity: CGFloat = 0.0
		let extraSpace = CGSize(width: 20.0, height: 12.0)
		let color = UIColor.systemOrange

		let style = TTGTextTagStyle()
		style.backgroundColor = color
		style.cornerRadius = cornerRadiusValue
		style.borderWidth = 0.0
		style.shadowOpacity = shadowOpacity
		style.extraSpace = extraSpace

		let selectedStyle = TTGTextTagStyle()
		selectedStyle.backgroundColor = .white
		selectedStyle.cornerRadius = cornerRadiusValue
		selectedStyle.shadowOpacity = shadowOpacity
		selectedStyle.extraSpace = extraSpace
		selectedStyle.borderColor = color

		tags.forEach { tag in
			let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
			let tagContent = TTGTextTagStringContent(text: tag,
													 textFont: font,
													 textColor: .white)
			let selectedTagContents = TTGTextTagStringContent(text: tag,
															  textFont: font,
															  textColor: color)

			let tags = TTGTextTag(content: tagContent,
								  style: style,
								  selectedContent: selectedTagContents,
								  selectedStyle: selectedStyle)

			tagCollectionView.addTag(tags)
		}
		tagCollectionView.reload()
	}
}
