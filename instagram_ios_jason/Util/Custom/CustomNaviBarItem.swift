//
//  CustomNaviBarItem.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class CustomNaviBarItem: UIButton {
    
    var config: CustomNaviBarItemConfig
    
    init(config: CustomNaviBarItemConfig) {
        self.config = config
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.titleLabel?.textColor = .label
        self.titleLabel?.tintColor = .label
        self.tintColor = .white
        
        self.setTitle(config.title, for: .normal)
        self.setImage(config.image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        self.config.handler()
    }
}

struct CustomNaviBarItemConfig {
    var title: String?
    var image: UIImage?
    var handler: (() -> Void)
    
    init(title: String? = nil, image: UIImage? = nil, handler: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}
