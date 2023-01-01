//
//  ProfileViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    var user: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        if let user = user {
            self.navigationItem.title = user.id
        }
    }
}
