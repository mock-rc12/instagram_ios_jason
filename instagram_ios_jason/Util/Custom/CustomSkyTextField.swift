//
//  CustomSkyTextField.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit
import SkyFloatingLabelTextField

class CustomSkyTextField: SkyFloatingLabelTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCustomUI()
    }
    
    private func setupCustomUI() {
        self.textColor = .white
        self.selectedTitleColor = .lightGray
        self.selectedLineColor = .white
        self.tintColor = .lightGray
    }
}
