//
//  EditDetailViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit

class EditDetailViewController: UIViewController {
    @IBOutlet weak var userTextField: CustomSkyTextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var editType: EditType!
    var userData: ProfileResult!
    var delegate: EditProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        switch editType {
        case .profileImage:
            print("")
        case .name:
            setupTextField(text: userData.name ?? "", placeholder: "이름")
            descriptionLabel.text = "사람들이 이름, 별명 또는 비즈니스 이름 등 회원님의 알려진 이름을 사용하여 회원님의 계정을 찾을 수 있도록 도와주세요. 이름은 14일 안에 두 번만 변경할 수 있습니다."
        case .id:
            setupTextField(text: userData.userId, placeholder: "사용자 이름")
            descriptionLabel.text = "대부분의 경우 이후 14일 동안 사용자 이름을 \(userData.userId)(으)로 변경할 수 있습니다."
        case .introduction:
            setupTextField(text: userData.introduction ?? "", placeholder: "소개")
            descriptionLabel.text = "멋진 자기 소개를 입력해주세요"
        case .website:
            setupTextField(text: userData.website ?? "", placeholder: "링크")
            descriptionLabel.text = "자신의 웹사이트를 보여주세요"
        case .transitionToProfessional:
            print("")
        case .privateSetting:
            print("")
        default:
            print("")
        }
        
        setupNV()
    }
    
    private func setupTextField(text: String, placeholder: String) {
        userTextField.text = text
        userTextField.placeholder = placeholder
    }
    
    private func setupNV() {
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backbutton
        self.navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    @objc private func backButtonTapped() {
        
        switch editType {
        case .name, .id:
            if userTextField.text != nil && userTextField.text != "" {
                popVcWithData(value: userTextField.text!, type: self.editType)
            }
        case .introduction, .website:
            if userTextField != nil {
                popVcWithData(value: userTextField.text!, type: self.editType)
            }
        default:
            print("")
        }
    }
    
    private func popVcWithData(value: String, type: EditType) {
        delegate?.backButtonTapped(value: value, type: type)
        self.navigationController?.popViewController(animated: true)
    }
}
