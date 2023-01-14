//
//  SignInViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit
import SkyFloatingLabelTextField
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: BaseViewController {
    
    // 텍스트 필드
    @IBOutlet weak var emailTextField: CustomSkyTextField!
    @IBOutlet weak var passwordTextField: CustomSkyTextField!
    
    // 버튼
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    @IBOutlet weak var spacingView: UIView!
    
    private let emailPlaceholder = "사용자 이름, 이메일 주소 또는 휴대폰 번호"
    private let passwordPlaceholder = "비밀번호"
    private let textFieldBackground = #colorLiteral(red: 0.2036902905, green: 0.2806001306, blue: 0.3262865543, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginUI()
        buttonSetupUI()
    }
    
    private func setupLoginUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        emailTextField.placeholder = emailPlaceholder
        emailTextField.title = emailPlaceholder
        
        passwordTextField.placeholder = passwordPlaceholder
        passwordTextField.title = passwordPlaceholder
        passwordTextField.isSecureTextEntry = true
        
//        textFieldSetupUI(field: [emailTextField, passwordTextField])
    }
    
    private func textFieldSetupUI(field: [SkyFloatingLabelTextField]) {
        field.forEach { field in
            field.textColor = .white
            field.selectedTitleColor = .lightGray
            field.selectedLineColor = .white
            field.tintColor = .lightGray
        }
    }
    
    private func buttonSetupUI() {
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.white.cgColor
        
        facebookLoginButton.layer.cornerRadius = 5
        facebookLoginButton.clipsToBounds = true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let userInfo = UserLoginData(email: email, phone: "", password: password)
            
            print(userInfo)
            let manager = LoginNetworkManager()
            manager.postLoginNetworkData(param: userInfo) { isSuccess in
                if isSuccess == true {
                    self.loginSuccess()
                } else {
                    print("로그인 실패")
                }
            }
        } else {
            showToast("영역을 모두 채워주세요", withDuration: 2, delay: 1.5)
        }
    }
    
    func loginSuccess() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    // MARK: - 페이스북 로그인
    @IBAction func facebookLoginButtonTapped(_ sender: UIButton) {
        facebookLogin(sender)
    }
    
    func facebookLogin(_ sender: Any) {
        let loginManager = LoginManager()

        loginManager.logIn(permissions: ["public_profile", "email"], from: self) {(result, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            guard let result = result, !result.isCancelled else {
                print("User cancelled login")
                return
            }
            
            GraphRequest.init(graphPath: "me", parameters: ["fields": "id, name, email, picture"]).start { (connection, result, error) in
                guard let fb = result as? [String: AnyObject] else { return }

                let token = fb["id"] as? String
                let name = fb["name"] as? String
                let email = fb["email"] as? String
                var profile = ""
                if let profileImg = fb["picture"] as? [String: AnyObject],
                let data = profileImg["data"] as? [String: AnyObject] {
                    profile = data["url"] as? String ?? ""
                }

                print("token: ", token ?? "no token")
                print("name: ", name ?? "no name")
                print("email: ", email ?? "no email")
                print("prfile_image: ", profile)
                
                self.loginSuccess()
            }
        }
    }

    // MARK: - 페이스북 로그아웃
    func facebookLogout(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        print("facebook logout")
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {

        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { print("가드문"); return }
        vc.infoType = .email
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showToast(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
        
        self.view.addSubview(toastLabel)
        NSLayoutConstraint.activate([
            toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100)
        ])
        toastLabel.layer.zPosition = 999
        
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
