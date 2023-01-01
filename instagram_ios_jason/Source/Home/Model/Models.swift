//
//  FeedModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

struct Profile {
    var id: String
    var name: String
    var profileImage: UIImage = UIImage(named: "default_profile")!
}

struct Feed {
    var user: Profile
    var media: [String]
    var likeCount: Int
    var commentCount: Int
    var body: String
}
