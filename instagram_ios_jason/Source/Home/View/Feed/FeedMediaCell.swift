//
//  FeedMediaCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit
import Kingfisher

class FeedMediaCell: UICollectionViewCell {
    
    var imageName: String?
    
    var feedImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupUI() {
        self.addSubview(feedImage)
        NSLayoutConstraint.activate([
            feedImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            feedImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            feedImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            feedImage.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        if imageName != nil {
            kingfisher()
        }
        feedImage.clipsToBounds = true
    }
    
    func kingfisher() {
        let defaultImage = "https://instastatistics.com/images/default_avatar.jpg"
        
        let url = URL(string: imageName ?? defaultImage)
        
        feedImage.kf.setImage(with: url)
        
    }
}
