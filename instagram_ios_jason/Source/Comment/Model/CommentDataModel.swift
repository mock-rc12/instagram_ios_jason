//
//  CommentDataModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/11.
//

import Foundation

struct CommentDataModel: Codable {
    
    let reply: String
    let depth: Int
    let commentAIdx: Int
    
}
