//
//  SignUpNetworkManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/03.
//

import Foundation
import Alamofire

class SignUpNetworkManager {
    
    func postSignUpNetworkData(param: UserDataModel, completion: @escaping (Bool) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathSignUp)"
        
        AF.request(url, method: .post, parameters: param, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: UserSecretResponse.self) { response in
                switch response.result {
                case .success(let result):
                    print("============성공==========")
                    print(result.message)
                    print(result.result.jwt)
                    print(result.result.userIdx)
                    completion(true)
                case .failure(let error):
                    print("============실패==========")
                    print(error)
                    print(error.responseCode ?? "")
                    completion(false)
                }
            }
    }
}
