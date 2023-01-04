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
}
