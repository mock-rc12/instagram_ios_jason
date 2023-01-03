//
//  UserModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/04.
//

import Foundation

struct UserDataModel: Codable {
    var userId: String
    var password: String
    var name: String
    var phone: String = ""
    var email: String
    var birth: String
    var contract1: String = "Y"
    var contract2: String = "Y"
    var contract3: String = "Y"
}


struct SignUpResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignUpResult
}

// MARK: - Result
struct SignUpResult: Codable {
    let jwt: String
    let userIdx: Int
}
