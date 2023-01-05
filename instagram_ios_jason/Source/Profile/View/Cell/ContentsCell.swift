//
//  ContentsCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/04.
//

import UIKit
import Kingfisher

class ContentsCell: UICollectionViewCell {

    @IBOutlet weak var contentsThumnailImageView: UIImageView!
    
    var item: ProfilePostImg?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure() {
        if let safeItem = item {
            let url = URL(string: safeItem.postImgUrl)
            contentsThumnailImageView.kf.setImage(with: url)
        }
    }
}
