//
//  CommentDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/11.
//

import Foundation
import Alamofire

class CommentDataManasger {
    func commentNetworkData(userIdx: Int, postIdx: Int, param: CommentDataModel, completion: @escaping (Bool) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathPostComment)userIdx=\(userIdx)&postIdx=\(postIdx)"
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
