//
//  UserProfileModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation

struct UserProfileModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProfileResult
}

// MARK: - Result
struct ProfileResult: Codable {
    let userIdx: Int
    let userId, name: String
    let introduction, profileImg, website: String?
    let postCount, followerCount, followingCount: Int
    let profilePostImgs: [ProfilePostImg]
//
//    enum CodingKeys: String, CodingKey {
//        case userIdx
//        case userId
//        case name, introduction, profileImg, website, postCount, followerCount, followingCount, profilePostImgs
//    }
}

// MARK: - ProfilePostImg
struct ProfilePostImg: Codable {
    let postIdx: Int
    let postImgUrl: String
//
//    enum CodingKeys: String, CodingKey {
//        case postIdx
//        case postImgURL
//    }
}
