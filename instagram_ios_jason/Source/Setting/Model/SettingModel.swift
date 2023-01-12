//
//  SettingModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit

struct SettingModel {
    enum Setting {
        case invite
        case notification
        case privateProtection
        case administration
        case security
        case advertisement
        case account
        case help
        case infomation
    }
    
    var image: UIImage?
    var title: String
    var settingType: Setting
}

// MARK: - PersonalInfoModel
struct PersonalInfoModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: PersonalInfoResult
}

// MARK: - Result
struct PersonalInfoResult: Codable {
    let userIdx: Int
    let email, phone, sex: String?
    let birth: String?
}
