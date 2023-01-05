//
//  NewPostModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation

struct NewPostModel: Codable {
    var content: String
    var postImgReqs: [PostImg]?
}

struct PostImg: Codable {
    var postImgUrl: String?
}
