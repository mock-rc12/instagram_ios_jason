//
//  AccountInfoHeader.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class AccountInfoHeader: UITableViewHeaderFooterView {
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        return label
    }()
    
    func configure() {
        self.contentView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class AccountHeaderView: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
