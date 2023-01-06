//
//  FeedMenuDataModel.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import UIKit

enum OtherFeedMenuType {
    case addFavorite
    case cancelFollow
    case reason
    case hideFeed
    case report
}

enum MyFeedMenuType {
    case keep
    case hideLikeCount
    case disableCommentFeat
    case modifyFeed
    case pinToMyProfile
    case share
    case deleteFeed
}

struct FeedMenuModel {
    var title: String
    var icon: UIImage?
    var otherType: OtherFeedMenuType?
    var myType: MyFeedMenuType?
    var section: Int
}

struct FeedMenuData {    
    static func getOtherMenuData() -> [FeedMenuModel] {
        let datas = [
            FeedMenuModel(title: "즐겨찾기에 추가", icon: UIImage(systemName: "star"), otherType: .addFavorite, section: 0),
            FeedMenuModel(title: "팔로우 취소", icon: UIImage(systemName: "person.crop.circle.badge.minus"), otherType: .cancelFollow, section: 0),
            FeedMenuModel(title: "이 게시물이 표시되는 이유", icon: UIImage(systemName: "info.circle"), otherType: .reason, section: 1),
            FeedMenuModel(title: "숨기기", icon: UIImage(systemName: "eye.slash"), otherType: .hideFeed, section: 1),
            FeedMenuModel(title: "신고", icon: UIImage(systemName: "info.bubble.fill"), otherType: .report, section: 1)
        ]
        return datas
    }
    
    static func getMyMenuData() -> [FeedMenuModel] {
        let datas = [
            FeedMenuModel(title: "보관", icon: UIImage(systemName: "clock.arrow.2.circlepath"), myType: .keep, section: 0),
            FeedMenuModel(title: "좋아요 수 숨기기", icon: UIImage(systemName: "heart.slash"), myType: .hideLikeCount, section: 0),
            FeedMenuModel(title: "댓글 기능 해제", icon: UIImage(systemName: "questionmark.bubble"), myType: .disableCommentFeat, section: 0),
            FeedMenuModel(title: "수정", icon: UIImage(systemName: "pencil"), myType: .modifyFeed, section: 0),
            FeedMenuModel(title: "내 프로필에 고정", icon: UIImage(systemName: "pin"), myType: .pinToMyProfile, section: 0),
            FeedMenuModel(title: "다른 앱에 게시", icon: UIImage(systemName: "square.and.arrow.up"), myType: .share, section: 0),
            FeedMenuModel(title: "삭제", icon: UIImage(systemName: "trash"), myType: .deleteFeed, section: 0)
        ]
        return datas
    }
}
