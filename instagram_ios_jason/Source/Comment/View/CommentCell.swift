//
//  CommentCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/10.
//

import UIKit
import Kingfisher

class CommentCell: UITableViewCell {

    var comment: PostContentRe?
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var commentLikeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
    
    func configure() {

        if let data = comment {
            if data.profileImg != nil && data.profileImg != "" {
                let url = URL(string: data.profileImg ?? "")
                userProfileImageView.kf.setImage(with: url)
            } else {
                userProfileImageView.image = Constant.defaultImage
            }
            
            idLabel.text = data.userId
            
            guard let count = data.commentLikeCount else { return }
            
            if count == 0 {
                commentLikeCountLabel.text = ""
            } else {
                commentLikeCountLabel.text = "좋아요 \(count)개"
            }
            timeLabel.text = data.updatedAt
            setupLabel(data: data)
        }
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
        userProfileImageView.clipsToBounds = true
    }
    
    func setupLabel(data: PostContentRe) {
        
        let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: idLabel.font.pointSize, weight: .bold)
        tempLabel.text = data.userId
        
        let text = data.reply
        let attString = NSMutableAttributedString(string: text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = tempLabel.intrinsicContentSize.width + 8
        attString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attString.length))
        attString.addAttribute(NSAttributedString.Key.font, value: bodyLabel.font as Any, range: NSMakeRange(0, attString.length))
        bodyLabel.attributedText = attString

        contentView.bringSubviewToFront(idLabel)
        
        bodyLabel.isUserInteractionEnabled = true
        idLabel.isUserInteractionEnabled = true
        
        let idGesture = UITapGestureRecognizer(target: self, action: #selector(idLabelTapped))
        let bodyGesture = UITapGestureRecognizer(target: self, action: #selector(bodyLabelTapped))
        
        idLabel.addGestureRecognizer(idGesture)
        bodyLabel.addGestureRecognizer(bodyGesture)
    }
    
    @objc func bodyLabelTapped() {
        print(#function)
    }
    
    @objc func idLabelTapped() {
        print(#function)
    }
}
