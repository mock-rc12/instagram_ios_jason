//
//  RecommandDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import Foundation
import Alamofire

class RecommandDataManager {
    
    func getRecomFeedsNetworkData(postIdx: Int, completion: @escaping ([FeedsResult]) -> Void) {
        let url = "\(Constant.BASE_URL)\(Constant.recommandFeed)/\(postIdx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        print(url)
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: FeedsModel.self) { response in
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
    
}
