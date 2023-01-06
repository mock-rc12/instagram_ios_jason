//
//  FeedMenuDelegate.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/07.
//

import Foundation

protocol FeedMenuDelegate {
    func deleteDone()
    func modifyTapped(feeds: FeedsResult)
}
