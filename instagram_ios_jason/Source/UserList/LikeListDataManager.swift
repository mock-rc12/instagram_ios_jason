//
//  LikeListDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/11.
//

import Foundation
import Alamofire

class LikeListDataManager {
    func likeUserListNetworkData(userIdx: Int, postIdx: Int, completion: @escaping ([LikeListResult]) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathLikeList)userIdx=\(userIdx)&postIdx=\(postIdx)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        print(url)
        
        AF.request(url, headers: headers)
            .responseDecodable(of: LikeListModel.self, completionHandler: { response in
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
