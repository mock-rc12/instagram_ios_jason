//
//  FollowModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/09.
//

import UIKit

// MARK: - FollowModel
struct FollowModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FollowResult]
}

// MARK: - Result
struct FollowResult: Codable {
    let userIdx: Int
    let name: String?
    let profileImg: String?
    let id, status, followYn: String
}
