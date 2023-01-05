//
//  ProfileDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation
import Alamofire

class ProfileDataManager {
    func getProfileNetworkData(userIdx: Int, completion: @escaping (ProfileResult) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathProfilesGet)\(userIdx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])

        AF.request(url, headers: headers)
            .responseDecodable(of: UserProfileModel.self, completionHandler: { response in
                switch response.result {
                case .success(let response):
                    print("====성공===")
                    completion(response.result)
                case .failure(let error):
                    print("====실패===")
                    print(error)
                }
            })
    }
    
    func editProfileNetworkData(param: EditProfileModle, idx: Int, completion: @escaping (Bool) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathProfilesEdit)\(idx)"
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
        
//            .responseDecodable(of: UserSecretResponse.self) { response in
//                switch response.result {
//                case .success(let result):
//                    print("============성공==========")
//                    print(result.message)
//                    print(result.result.jwt)
//                    print(result.result.userIdx)
//                    completion(true)
//                case .failure(let error):
//                    print("============실패==========")
//                    print(error)
//                    print(error.responseCode ?? "")
//                    completion(false)
//                }
//            }
    }
}
