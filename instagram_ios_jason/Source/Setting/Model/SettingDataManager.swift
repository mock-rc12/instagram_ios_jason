//
//  SettingDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit

class SettingDataManager {
    
    var settings: [SettingModel] = []
    
    func fetchData() {
        let data = [
            SettingModel(image: UIImage(systemName: "person.badge.plus"), title: "친구 팔로우 및 초대", settingType: .invite),
            SettingModel(image: UIImage(systemName: "bell"), title: "알림", settingType: .notification),
            SettingModel(image: UIImage(systemName: "lock"), title: "개인정보 보호", settingType: .privateProtection),
            SettingModel(image: UIImage(systemName: "person.2"), title: "관리 감독", settingType: .notification),
            SettingModel(image: UIImage(systemName: "checkmark.shield"), title: "보안", settingType: .security),
            SettingModel(image: UIImage(systemName: "megaphone"), title: "광고", settingType: .advertisement),
            SettingModel(image: UIImage(systemName: "person.circle"), title: "계정", settingType: .account),
            SettingModel(image: UIImage(systemName: "button.programmable"), title: "도움말", settingType: .help),
            SettingModel(image: UIImage(systemName: "info.circle"), title: "정보", settingType: .infomation)
        ]
        settings = data
    }
    
    func getSettingData() -> [SettingModel] {
        fetchData()
        return settings
    }
}
