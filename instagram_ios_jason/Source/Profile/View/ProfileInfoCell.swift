//
//  ProfileInfoCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/04.
//

import UIKit
import Kingfisher

class ProfileInfoCell: UICollectionViewCell {
    
    var item: ProfileResult?

    // 프로필
    @IBOutlet weak var profileImageView: UIImageView!
    
    // 카운트
    @IBOutlet weak var contentsCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    // 정보
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        if let safeItem = item {
            
            if safeItem.profileImg != nil {
                let imageUrl = URL(string: safeItem.profileImg ?? "")
                profileImageView.kf.setImage(with: imageUrl)
            } else {
                profileImageView.kf.setImage(with: URL(string: Constant.defaultImage))
                imageViewRound()
            }
            
            contentsCountLabel.text = "\(safeItem.postCount)"
            followerCountLabel.text = "\(safeItem.followerCount)"
            followingCountLabel.text = "\(safeItem.followingCount)"
            
            nameLabel.text = safeItem.name
            introductionLabel.text = safeItem.introduction
            websiteLabel.text = safeItem.website
        }
    }
    
    func imageViewRound() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
}
