//
//  User.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class UserModel {
    static var myProfile: Profile = Profile(id: "jisu.kim__", name: "김지수", profileImage: UIImage(named: "dummyProfile")!)
    
    static var george = Profile(id: "george_ohoh", name: "GEORGE", profileImage: (UIImage(named: "dummy_george") ?? UIImage(named: "default_profile"))!)
    
    static var tele = Profile(id: "Teletubbies", name: "Teletubbies", profileImage: (UIImage(named: "dummy_tele") ?? UIImage(named: "default_profile"))!)
    
    static var sunBaby = Profile(id: "sun_Baby", name: "cheolsu", profileImage: (UIImage(named: "dummy_sunBaby") ?? UIImage(named: "default_profile"))!)
    
    static var jongguk = Profile(id: "ghost_jongguk", name: "김종국")
    
    static var bazzi = Profile(id: "i_am_bazzi", name: "장배찌", profileImage: (UIImage(named: "dummy_bazzi") ?? UIImage(named: "default_profile"))!)
    
    static var dao = Profile(id: "yodaoMe", name: "다오", profileImage: (UIImage(named: "dummy_dao") ?? UIImage(named: "default_profile"))!)
    
    static var chunsik = Profile(id: "chun_chun_sikk", name: "김춘식", profileImage: (UIImage(named: "dummy_chunsik") ?? UIImage(named: "default_profile"))!)
}
