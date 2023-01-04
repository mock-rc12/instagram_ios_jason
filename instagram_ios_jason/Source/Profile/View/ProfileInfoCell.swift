//
//  ProfileInfoCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/04.
//

import UIKit
import Kingfisher

class ProfileInfoCell: UICollectionViewCell {
    
    var profileType: ProfileType = .myProfile
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
    
    private var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("읽어들이는 중", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        
        setupButton()
        
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
            introductionLabel.text = safeItem.introduction ?? "비어있음"
            websiteLabel.text = safeItem.website ?? "비어있음"
        }
    }
    
    private func setupButton() {
        self.addSubview(buttonStack)
        
        switch profileType {
        case .otherUserProfile:
            setupButtonUI(button: [followButton, messageButton])
        case .myProfile:
            setupButtonUI(button: [editProfileButton])
        }
        buttonConstraints()
    }
    
    private func setupButtonUI(button: [UIButton]) {
        _ = button.map {
            self.buttonStack.addArrangedSubview($0)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
    }
    
    private func buttonConstraints() {
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            buttonStack.topAnchor.constraint(equalTo: self.websiteLabel.bottomAnchor, constant: 15),
            buttonStack.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func imageViewRound() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
}
