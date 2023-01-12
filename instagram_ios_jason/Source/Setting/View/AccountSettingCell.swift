//
//  AccountSettingCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class AccountSettingCell: UITableViewCell {
    
    var settingTitle: String?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    var arrowImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.contentMode = .scaleAspectFit
        view.tintColor = .label
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        _ = [titleLabel, arrowImageView].map({
            stackView.addArrangedSubview($0)
        })
        
        if let title = settingTitle {
            titleLabel.text = title
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.width.equalTo(10)
        }
    }
    
    func setupSpecial() {
        titleLabel.textColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
        arrowImageView.removeFromSuperview()
    }
}
