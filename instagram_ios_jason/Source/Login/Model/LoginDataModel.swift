//
//  LoginDataModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/04.
//

import Foundation

struct UserLoginData: Codable {
    let email: String?
    let phone: String?
    let password: String
}
