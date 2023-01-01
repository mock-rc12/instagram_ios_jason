//
//  HomeVCDelegate.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import Foundation

protocol HomeVCDelegate {
    func likeCountLabelTapped()
    func commentCountLabelTapped()
    func userIdLabelTapped(user: Profile)
    func moreImageTapped()
}
