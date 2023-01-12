//
//  SearchCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    
    var data: SettingModel?
    
    var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .label
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    var moreImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .label
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        _ = [iconImageView, titleLabel, moreImageView].map({
            stackView.addArrangedSubview($0)
        })
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.width.equalTo(15)
        }
        
        iconImageView.image = data?.image
        titleLabel.text = data?.title
    }
}
