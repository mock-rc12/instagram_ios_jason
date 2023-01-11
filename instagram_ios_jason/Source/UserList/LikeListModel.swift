//
//  LikeListModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/11.
//

import Foundation

struct LikeResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Bool
}

// MARK: - LikeListModel
struct LikeListModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LikeListResult]
}

// MARK: - Result
struct LikeListResult: Codable {
    let userIdx: Int
    let userId: String
    let name: String?
    let profileImg: String?
    let followStatus: String
}
