//
//  ProfileTabHeaderView.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit

class ProfileTabHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerTabBar: UITabBar!
    
    @IBOutlet weak var photoViewTabBarItem: UITabBarItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        headerTabBar.backgroundColor = .systemBackground
        headerTabBar.selectedItem = photoViewTabBarItem
    }
}
