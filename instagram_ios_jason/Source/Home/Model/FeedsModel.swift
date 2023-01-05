//
//  FeedModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

struct Profile {
    var id: String
    var name: String
    var profileImage: UIImage = UIImage(named: "default_profile")!
}

struct Feed {
    var user: Profile
    var media: [String]
    var likeCount: Int
    var commentCount: Int
    var body: String
}

// MARK: - FeedsModel
struct FeedsModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FeedsResult]
}

// MARK: - Result
struct FeedsResult: Codable {
    let postIdx: Int
    let content: String
    let userIdx: Int
    let userId: String
    let profileImgUrl: String?
    let postLikeCount: Int
    let commentCount: Int?
    let updateAt: String
    let postImgRes: [FeedsPostImgRe]?
}

// MARK: - PostImgRe
struct FeedsPostImgRe: Codable {
    let postImgIdx: Int?
    let postImgUrl: String?
}
