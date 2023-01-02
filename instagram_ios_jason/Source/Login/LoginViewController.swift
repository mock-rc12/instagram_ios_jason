//
//  SignInViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit
import FacebookLogin

class LoginViewController: UIViewController {
    
    let loginButton = FBLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        facebookLoginSetup()
    }
    
    func facebookLoginSetup() {
        loginButton.center = view.center
        view.addSubview(loginButton)
    }
    
    func facebookLoginConstraints() {

    }
}
