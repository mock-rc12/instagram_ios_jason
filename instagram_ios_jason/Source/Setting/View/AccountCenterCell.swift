//
//  AccountCenterCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class AccountCenterCell: UITableViewCell {
    
    var accountCenterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "accountInfo")
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure() {
        self.contentView.addSubview(accountCenterImageView)
        accountCenterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
