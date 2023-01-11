//
//  SearchDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/10.
//

import Foundation
import Alamofire

class SearchDataManager {
    func getSearchNetworkData(userIdx: Int, word: String, completion: @escaping ([SearchResult]) -> Void) {
        let url = "\(Constant.BASE_URL)\(Constant.getSearchData)/\(userIdx)/users?word=\(word)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: SearchModel.self) { response in
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
    
    func getRecommandNetworkData(completion: @escaping ([RecommandFeedResult]) -> Void) {
        let url = "\(Constant.BASE_URL)\(Constant.recommandFeed)"
        print("💡💡💡\(url)")
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: RecommandFeedModel.self) { response in
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


