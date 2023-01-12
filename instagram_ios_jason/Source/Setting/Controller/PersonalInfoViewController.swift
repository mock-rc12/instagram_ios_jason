//
//  PersonalInfoViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var personalInfo: PersonalInfoResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        self.navigationItem.title = "개인정보"
    }
    
    func getData() {
        SettingDataManager().getPersonalInfoNetworkData(userIdx: Secret.userIdx) { [weak self] result in
            self?.personalInfo = result
            self?.setupUI()
        }
    }
    
    func setupUI() {
        if let data = personalInfo {
            emailTextField.text = data.email
            birthTextField.text = data.birth
            sexTextField.text = data.sex
            phoneTextField.text = data.phone
        }
        
        let barItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    @objc func doneButtonTapped() {
        if emailTextField.text != nil || phoneTextField.text != nil {
            if emailTextField.text != "" || phoneTextField.text != "" {
                
                let email = emailTextField.text
                let phone = phoneTextField.text
                let birth = birthTextField.text
                let sex = sexTextField.text
                
                let param = PersonalInfoResult(userIdx: Secret.userIdx, email: email, phone: phone, sex: sex, birth: birth)
                
                SettingDataManager().patchPersonalInfoNetworkData(userIdx: Secret.userIdx, param: param) { isSuccess in
                    if isSuccess == true {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
