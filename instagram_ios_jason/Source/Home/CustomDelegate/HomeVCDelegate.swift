//
//  HomeVCDelegate.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import Foundation

protocol HomeVCDelegate {
    func likeCountLabelTapped(item: FeedsResult)
    func commentCountLabelTapped(user: FeedsResult)
    func userIdLabelTapped(user: FeedsResult)
    func moreImageTapped(item: FeedsResult)
    func feedUploadSuccessed()
    func feedModifySuccessed()
    func likeButtonTapped(data: FeedsResult)
    func shareButtonTapped()
    func messageButtonTapped()
}
