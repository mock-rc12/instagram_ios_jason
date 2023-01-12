//
//  SettingDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import Alamofire

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
    
    
    func getPersonalInfoNetworkData(userIdx: Int, completion: @escaping (PersonalInfoResult) -> Void) {
        let url = "\(Constant.BASE_URL)\(Constant.getPersonalInfo)\(userIdx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        print(url)
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PersonalInfoModel.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true {
                        print("========성공======")
                        completion(response.result)
                    } else {
                        print("에러 발생 \(response.message)")
                    }
                case .failure(let error):
                    print("에러 발생 \(error)")
                }
            }
    }
    
    func patchPersonalInfoNetworkData(userIdx: Int, param: PersonalInfoResult ,completion: @escaping (Bool) -> Void) {
        let url = "\(Constant.BASE_URL)\(Constant.getPersonalInfo)\(userIdx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        AF.request(url, method: .patch, parameters: param, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true {
                        completion(true)
                    } else {
                        print("에러 발생")
                    }
                case .failure(let error):
                    print("에러 발생 \(error)")
                }
            }
    }
}
