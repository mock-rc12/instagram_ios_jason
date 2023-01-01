//
//  HomeDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class HomeDataManager {
    
    public static var shared = HomeDataManager()
    
    private init() {}
    
    var users: [Profile] = []
    var feeds: [Feed] = []
    
    func fetchDummyData() {
        users = [UserModel.bazzi, UserModel.chunsik, UserModel.george, UserModel.dao, UserModel.jongguk, UserModel.sunBaby, UserModel.tele]
        
        feeds = [
            Feed(user: UserModel.tele, media: ["tele00", "tele01", "tele02"], likeCount: 15, commentCount: 5, body: "친구들과 함께했었던 2022년의 텔레토비 🙌"),
            Feed(user: UserModel.chunsik, media: ["chunsik00"], likeCount: 52, commentCount: 8, body: "산...좋다...🏔️"),
            Feed(user: UserModel.bazzi, media: ["bazzi00", "bazzi01", "bazzi02"], likeCount: 5, commentCount: 2, body: "리!즈!시!절!"),
            Feed(user: UserModel.george, media: ["george00", "george01", "george02", "george03"], likeCount: 124, commentCount: 23, body: "셀카들 담아가세요 ~"),
            Feed(user: UserModel.dao, media: ["dao00"], likeCount: 24, commentCount: 1, body: "나도 산 갔다옴"),
            Feed(user: UserModel.jongguk, media: ["dummy00", "dummy01", "dummy02", "dummy03"], likeCount: 32, commentCount: 1, body: "더미란 무엇인가? 그것 참 힘든 문제야, 이걸 찾는데 시간이 많이 걸린다니까?"),
        ]
    }
    
    func getStoryDummyData() -> [Profile] {
        return users
    }
    
    func getFeedData() -> [Feed] {
        return feeds
    }
}
