//
//  ProfileVCDelegate.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import Foundation

protocol ProfileVCDelegate {
    func followReqButtonTapped()
    func followingButtonTapped()
    func messageButtonTapped()
    func editProfileButtonTapped()
    func profileEditSuccess()
    func followingLabelTapped()
    func followerLabelTapped()
}

protocol EditProfileDelegate {
    func backButtonTapped(value: String, type: EditType)
}

protocol EditDoneDelegate {
    func editSucess()
}
