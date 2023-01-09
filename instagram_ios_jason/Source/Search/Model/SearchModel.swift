//
//  SearchModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/10.
//

import UIKit

// MARK: - SearchModel
struct SearchModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [SearchResult]
}

// MARK: - Result
struct SearchResult: Codable {
    let userIdx: Int
    let name, detail: String
    let img: String?
    let cnt: Int
}
