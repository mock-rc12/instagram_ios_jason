//
//  PostModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import Foundation

// MARK: - PostModel
struct PostModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: PostResult
}

// MARK: - Result
struct PostResult: Codable {
    let postIdx: Int
    let content: String
    let userIdx: Int
    let userId: String
    let profileImgUrl: String?
    let postLikeCount: Int
    let updateAt: String
    let postImgRes: [FeedsPostImgRe]?
    let postContentRes: [PostContentRe]?
}

// MARK: - PostContentRe
struct PostContentRe: Codable {
    let postCommentIdx: Int?
    let reply: String?
    let depth, userIdx: Int?
    let userId: String?
    let updatedAt: String?
    let commentLikeCount: Int?
    let profileImg: String?
    let commentIdxA: Int?
}

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
    let profileImg: String?
    let followStatus: String
}
