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
    var delegate: ProfileVCDelegate?
    var indexpath: IndexPath?
    
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
    
    // 스택뷰
    @IBOutlet weak var followerStackView: UIStackView!
    @IBOutlet weak var followingStackView: UIStackView!
    
    private var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("읽어들이는 중", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var followingButton: UIButton = {
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
        button.addTarget(nil, action: #selector(messageButtonTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(editProfileButtonTapped), for: .touchUpInside)
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
        print(#function)
        buttonStack.arrangedSubviews.forEach {
            buttonStack.removeArrangedSubview($0)
        }
    }
    
    override func prepareForReuse() {
        print(#function)
        buttonStack.arrangedSubviews.forEach {
            buttonStack.removeArrangedSubview($0)
        }
    }
    
    func configure() {
        
        setupButton()
        
        if let safeItem = item {
            
            if safeItem.profileImg != nil {
                let imageUrl = URL(string: safeItem.profileImg ?? "")
                profileImageView.kf.setImage(with: imageUrl)
                imageViewRound()
            } else {
                profileImageView.image = Constant.defaultImage
                imageViewRound()
            }
            
            contentsCountLabel.text = "\(safeItem.postCount)"
            followerCountLabel.text = "\(safeItem.followerCount)"
            followingCountLabel.text = "\(safeItem.followingCount)"
            
            nameLabel.text = safeItem.name
            introductionLabel.text = safeItem.introduction ?? "비어있음"
            websiteLabel.text = safeItem.website ?? "비어있음"
        }
        
        followingStackView.isUserInteractionEnabled = true
        followerStackView.isUserInteractionEnabled = true
        let followingGesture = UITapGestureRecognizer(target: self, action: #selector(followingLabelTapped(_:)))
        let followerGesture = UITapGestureRecognizer(target: self, action: #selector(followerLabelTapped(_:)))
        followingStackView.addGestureRecognizer(followingGesture)
        followerStackView.addGestureRecognizer(followerGesture)
    }
    
    @objc func followingLabelTapped(_ sender: UITapGestureRecognizer) {
        delegate?.followingLabelTapped()
    }
    
    @objc func followerLabelTapped(_ sender: UITapGestureRecognizer) {
        delegate?.followerLabelTapped()
    }
    
    private func setupButton() {
        self.addSubview(buttonStack)
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥ITEM")
        dump(item!.followStatus)
        switch item!.followStatus {
        case "ACTIVE":
            print("🔥🔥🔥여기 안걸리냐")
            setupButtonUI(button: [followingButton, messageButton])
            followingButton.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
            followingButton.setTitle("팔로잉 ▼", for: .normal)
            followingButton.addTarget(nil, action: #selector(followingButtonTapped), for: .touchUpInside)
        case "INACTIVE":
            setupButtonUI(button: [followButton, messageButton])
            followButton.backgroundColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
            followButton.setTitle("팔로우", for: .normal)
            followButton.addTarget(nil, action: #selector(followButtonTapped), for: .touchUpInside)
        default:
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
    
    private func imageViewRound() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
    
    @objc private func followButtonTapped() {
        delegate?.followReqButtonTapped()
    }
    
    @objc private func followingButtonTapped() {
        delegate?.followingButtonTapped()
    }
    
    @objc private func messageButtonTapped() {
        delegate?.messageButtonTapped()
    }
    
    @objc private func editProfileButtonTapped() {
        delegate?.editProfileButtonTapped()
    }
    //
    //    func followButtonChange() {
    //        followButton.setTitle("팔로우 중", for: .normal)
    //        followButton.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
    //    }
}
