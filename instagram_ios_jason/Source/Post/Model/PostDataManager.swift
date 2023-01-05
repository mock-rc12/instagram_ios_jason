//
//  PostDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import UIKit
import Alamofire

class PostDataManager {
    func getPostNetworkData(idx: Int, completion: @escaping (PostResult) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathPostGet)\(idx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])

        AF.request(url, headers: headers)
            .responseDecodable(of: PostModel.self, completionHandler: { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true {
                        completion(response.result)
                    } else {
                        print("====실패===")
                    }
                case .failure(let error):
                    print("====실패===")
                    print(error)
                }
            })
    }
}
