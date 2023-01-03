//
//  SignUpViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit

class SignUpViewController: BaseViewController {
       
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userInfoTextField: CustomSkyTextField!
    @IBOutlet weak var nextButton: UIButton!
    
    let placeholder = "이메일 주소"
    var guideDatas = SignUpGuideData()
    var infoType: SignUpUserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        nextButton.layer.cornerRadius = 5
        nextButton.clipsToBounds = true
        
        if let inputType = infoType {
            switch inputType {
            case .email:
                configure(data: guideDatas.email)
            case .password:
                configure(data: guideDatas.password)
                userInfoTextField.isSecureTextEntry = true
            case .name:
                configure(data: guideDatas.name)
            case .id:
                configure(data: guideDatas.id)
            case .birthday:
                configure(data: guideDatas.birthday)
            case .sucess:
                // 회원가입 완료 여부 체크
                sendSignUpData()
            case .failure:
                configure(data: guideDatas.fail)
            }
        }
    }
    
    private func configure(data: SignUpGuideModel) {
        titleLabel.text = data.title
        bodyLabel.text = data.body
        userInfoTextField.title = data.placeholder
        userInfoTextField.placeholder = data.placeholder
    }
    
    private func getTextFieldData(completion: @escaping (String) -> Void) {
        if let userText = userInfoTextField.text {
            completion(userText)
        } else {
            print("값이 없습니다")
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let inputType = infoType {
            switch inputType {
            case .email:
                getTextFieldData { [weak self] text in
                    SignUpDataManager.email = text
                    self?.pushVC(type: .password)
                }
            case .password:
                getTextFieldData { [weak self] text in
                    SignUpDataManager.password = text
                    self?.pushVC(type: .name)
                }
            case .name:
                getTextFieldData { [weak self] text in
                    SignUpDataManager.name = text
                    self?.pushVC(type: .id)
                }
            case .id:
                getTextFieldData { [weak self] text in
                    SignUpDataManager.userId = text
                    self?.pushVC(type: .birthday)
                }
            case .birthday:
                getTextFieldData { [weak self] text in
                    SignUpDataManager.birth = text
                    self?.pushVC(type: .sucess)
                }
            case .sucess:
                self.navigationController?.dismiss(animated: true)
            case .failure:
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func pushVC(type: SignUpUserInfo) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        vc.infoType = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func sendSignUpData() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        
        let manager = SignUpNetworkManager()
        let userInfo = UserDataModel(userId: SignUpDataManager.userId, password: SignUpDataManager.password, name: SignUpDataManager.name, email: SignUpDataManager.email, birth: SignUpDataManager.birth)
        
        // 네트워크 post
        manager.postSignUpNetworkData(param: userInfo) { [weak self] isSuccess in
            if isSuccess == true {
                // 성공한 경우, UI 변경
                IndicatorView.shared.dismiss()
                self?.configure(data: (self?.guideDatas.finish)!)
                self?.userInfoTextField.removeFromSuperview()
                self?.nextButton.setTitle("완료", for: .normal)
            } else {
                print("🚨🚨🚨🚨🚨🚨🚨🚨🚨 가입 실패")
                self?.infoType = .failure
                self?.setupUI()
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
