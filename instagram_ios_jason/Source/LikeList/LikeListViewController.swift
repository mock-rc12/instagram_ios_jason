//
//  LikeListViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit

class LikeListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "좋아요"
    }
}
