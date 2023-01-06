//
//  FeedMenuDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/07.
//  userIdx=?postIdx="

import Foundation
import Alamofire

class FeedMenuDataManager {
    func feedEditNetworkData(userIdx: Int, postIdx: Int, completion: @escaping (Bool) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathPostDelete)userIdx=\(userIdx)&postIdx=\(postIdx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        print(url)
        AF.request(url, method: .delete, headers: headers)
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true {
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    print("에러 발생 \(error)")
                    completion(false)
                }
            }
    }
}
