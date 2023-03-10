//
//  FollowDataManager.swift
//  instagram_ios_jason
//
//  Created by κΉμ§μ on 2023/01/09.
//

import UIKit
import Alamofire

class FollowDataManager {
    func getFollowNetworkData(type: UserListViewController.FollowType, userIdx: Int, followIdx: Int? = nil, completion: @escaping ([FollowResult]) -> Void) {
        var url = ""
        var pathUrl = ""
        switch type {
        case .followTogether:
            pathUrl = Constant.pathFollowTogether
        case .follower:
            pathUrl = Constant.pathGetFollower
        case .following:
            pathUrl = Constant.pathGetFollowing
        }
        
        if type == .followTogether {
            guard let followIdx = followIdx else { return }
            url = "\(Constant.BASE_URL)/\(userIdx)\(pathUrl)\(followIdx)"
        } else {
            url = "\(Constant.BASE_URL)/\(userIdx)\(pathUrl)"
        }
        print("π‘π‘π‘\(url)")
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: FollowModel.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true {
                        print("========μ±κ³΅======")
                        completion(response.result)
                    } else {
                        print("μλ¬ λ°μ \(response.message)")
                    }
                case .failure(let error):
                    print("μλ¬ λ°μ \(error)")
                }
            }
    }
}
