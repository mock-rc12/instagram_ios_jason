//
//  FeedsDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/03.
//

import Foundation
import Alamofire

class FeedsDataManager {
    
    func getFeedsNetworkData(completion: @escaping ([FeedsResult]) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathFeedsGet)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])

        AF.request(url, headers: headers)
            .responseDecodable(of: FeedsModel.self, completionHandler: { response in
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
