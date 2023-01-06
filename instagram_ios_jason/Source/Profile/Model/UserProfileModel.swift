//
//  UserProfileModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation

enum ProfileType {
    case otherUserProfile
    case myProfile
}

struct UserProfileModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProfileResult
}

// MARK: - Result
struct ProfileResult: Codable {
    let userIdx: Int
    var userId: String
    var name: String?
    var introduction, profileImg, website: String?
    var postCount, followerCount, followingCount: Int
    var profilePostImgs: [ProfilePostImg]
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
    let postImgUrl: String?
//
//    enum CodingKeys: String, CodingKey {
//        case postIdx
//        case postImgURL
//    }
}

struct EditProfileModle: Codable {
    var userIdx: Int
    var userId: String
    var name: String
    var profileImg: String?
    var website: String?
    var introduction: String?
}
