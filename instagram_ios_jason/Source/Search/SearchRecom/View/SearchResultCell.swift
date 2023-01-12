//
//  SearchResultCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/10.
//

import Kingfisher
import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var searchItem: SearchResult?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
    }
    
    func configure() {
        if let item = searchItem {
            idLabel.text = item.name
            descriptionLabel.text = item.detail
            
            if item.img == nil || item.img == "" {
                profileImageView.image = UIImage(named: "default_profile")
            } else {
                let url = URL(string: item.img ?? "")
                profileImageView.kf.setImage(with: url)
            }
        }
        
        profileImageView.layer.cornerRadius = (self.frame.height - 10) / 2
        profileImageView.clipsToBounds = true
        
    }
}
