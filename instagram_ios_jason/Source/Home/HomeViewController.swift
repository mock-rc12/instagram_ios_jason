//
//  HomeViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        let itemSize = CGFloat(25)
        let spacing = CGFloat(15)
        
        let titleConfig = CustomNaviBarItemConfig(image: UIImage(named: "instagram_logo")) {
            print("타이틀 버튼 눌림")
        }
        
        let messageConfig = CustomNaviBarItemConfig(image: UIImage(systemName: "paperplane")) {
            print("DM버튼 눌림")
        }
        
        let notiConfig = CustomNaviBarItemConfig(image: UIImage(systemName: "heart")) {
            print("알림 버튼 눌림")
        }
        
        let postConfig = CustomNaviBarItemConfig(image: UIImage(systemName: "plus.app")) {
            print("포스트 버튼 눌림")
        }
        
        let titleItem = UIBarButtonItem.generate(config: titleConfig, width: 130)
        let messageItem = UIBarButtonItem.generate(config: messageConfig, width: itemSize)
        let notiItem = UIBarButtonItem.generate(config: notiConfig, width: itemSize)
        let postItem = UIBarButtonItem.generate(config: postConfig, width: itemSize)
        let spacingItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        spacingItem.width = spacing
        
        navigationItem.leftBarButtonItem = titleItem
        navigationItem.rightBarButtonItems = [messageItem, spacingItem, notiItem, spacingItem, postItem]
    }
}
