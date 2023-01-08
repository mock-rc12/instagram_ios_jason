//
//  ProfileDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation
import Alamofire

class ProfileDataManager {
    func getProfileNetworkData(profileIdx: Int, userIdx: Int, completion: @escaping (ProfileResult) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathProfilesGet)?profileIdx=\(profileIdx)&userIdx=\(userIdx)"
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
    }
    
    func followReqNetworkData(param: FollowReqModle, idx: Int, completion: @escaping (Bool) -> Void) {
        
        let url = "\(Constant.BASE_URL)/\(idx)\(Constant.pathPostFollow)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        print("🔥🔥🔥🔥🔥🔥URL: \(url)")
        
        AF.request(url, method: .post, parameters: param, encoder: JSONParameterEncoder.default, headers: headers)
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
