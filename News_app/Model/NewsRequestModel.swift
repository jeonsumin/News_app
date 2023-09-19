//
//  NewsRequestModel.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import Foundation

struct NewsRequestModel: Codable {
	/// 검색 키워드
	let query: String

	/// 검색 결과 출력 건수,10 ~ 100
	let display: Int

	/// 시작 Index, 1 ~ 100
	let start: Int

}
