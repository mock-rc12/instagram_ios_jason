//
//  SignUpDataManager.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/03.
//

import UIKit

struct SignUpDataManager {
//    static var shared = SignUpDataManager()
    static var userId: String = ""
    static var password: String = ""
    static var name: String = ""
//    var phone: String
    static var email: String = ""
    static var birth: String = ""
    static var contract1: String = "Y"
    static var contract2: String = "Y"
    static var contract3: String = "Y"
}


struct SignUpGuideModel {
    var type: SignUpUserInfo
    var title: String
    var body: String
    var placeholder: String
}

struct SignUpGuideData {
    var email = SignUpGuideModel(type: .email, title: "이메일 주소 입력", body: "회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.", placeholder: "이메일")
    var name = SignUpGuideModel(type: .name, title: "이름 입력", body: "친구들이 회원님을 찾을 수 있도록 이름을 추가하세요.", placeholder: "성명")
    var password = SignUpGuideModel(type: .password, title: "비밀번호 만들기", body: "다른 사람이 추측할 수 없는 6자 이상의 문자와 숫자 조합으로 비밀번호를 만드세요.", placeholder: "비밀번호")
    var birthday = SignUpGuideModel(type: .birthday, title: "생년월일 입력", body: "비즈니스, 반려동물 또는 기타 목적으로 이 계정을 만드는 경우에도 회원님의 실제 생년월일을 사용하세요. 이 생년월일 정보는 프로필에서 다른 사람들에게 공개되지 않습니다.", placeholder: "생년월일")
    var id = SignUpGuideModel(type: .id, title: "사용자 이름 만들기", body: "사용자 이름을 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다.", placeholder: "아이디")
    var finish = SignUpGuideModel(type: .sucess, title: "회원가입 완료", body: "이제 인스타그램을 즐기세요 !", placeholder: "")
    var fail = SignUpGuideModel(type: .failure, title: "회원가입 실패", body: "다시 시도하세요", placeholder: "")
}

enum SignUpUserInfo: CaseIterable {
    case email
    case password
    case name
    case id
    case birthday
    case sucess
    case failure
}
