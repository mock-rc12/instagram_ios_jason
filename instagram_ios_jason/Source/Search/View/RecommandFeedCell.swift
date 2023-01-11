//
//  RecommandFeedCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/11.
//

import UIKit
import Kingfisher
import SnapKit

class RecommandFeedCell: UICollectionViewCell {
    var recommandData: RecommandFeedResult?
    
    var recommandImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constant.defaultImage
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func prepareForReuse() {
        recommandImageView.image = UIImage()
    }
    
    func configure() {
        setupUI()
        if let data = recommandData {
            if data.postImg != nil && data.postImg != "" {
                let url = URL(string: data.postImg!)
                recommandImageView.kf.setImage(with: url, placeholder: Constant.defaultImage)
            }
        }
    }
    
    func setupUI() {
        self.contentView.addSubview(recommandImageView)
        recommandImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
        recommandImageView.clipsToBounds = true
        self.contentView.clipsToBounds = true
    }
}
