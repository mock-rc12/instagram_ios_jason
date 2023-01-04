//
//  CustomNavigationController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.delegate = self
        
    }
    
    func clearBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if ((viewController as? LoginViewController) != nil) {
            self.navigationBar.isHidden = true
        } else if ((viewController as? SignUpViewController) != nil) {
            self.navigationBar.isHidden = true
        } else {
            self.navigationBar.isHidden = false
        }
    }
}
