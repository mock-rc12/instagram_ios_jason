//
//  NewPostDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation
import Alamofire

class NewPostDataManager {
    func newPostNetworkData(idx: Int, param: NewPostModel, completion: @escaping (Bool) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathPostCreate)\(idx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
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
