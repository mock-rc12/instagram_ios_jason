//
//  FollowCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/09.
//

import UIKit
import Kingfisher
import SnapKit

class FollowCell: UITableViewCell {
    
    enum FollowState: String, CaseIterable {
        case follow = "ACTIVE"
        case unFollow = "INACTIVE"
        
        var backgroundColor: UIColor {
            switch self {
            case .follow:
                return #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
            case .unFollow:
                return #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .follow:
                return "팔로잉"
            case .unFollow:
                return "팔로우"
            }
        }
    }
    
    var delegate: FollowStateDelegate?
    var currentState: FollowState?
    var contentType: FollowListViewController.followType!
    var followData: FollowResult?
    
    var profileFrame = UIImageView()
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var followButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        return button
    }()
    
    var idLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    var moreImageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: "ellipsis")
        image.contentMode = .scaleAspectFit
        image.tintColor = .label
        return image
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let spacing: CGFloat = 10
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing))
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
        setupUI()
        
        if let safeData = followData {

            FollowState.allCases.forEach { state in
                if state.rawValue == safeData.followYn {
                    currentState = state
                }
            }
            
            idLabel.text = safeData.id
            nameLabel.text = safeData.name
            profileFrame.image = UIImage(named: "storyBackground")
            
            if safeData.profileImg == nil {
                profileImageView.image = UIImage(named: "default_profile")
            } else {
                let url = URL(string: safeData.profileImg ?? "")
                profileImageView.kf.setImage(with: url)
            }
        }
        
        _ = [profileImageView, profileFrame].map({
            $0.clipsToBounds = true
        })
        
        profileImageView.layer.cornerRadius = 24
        profileFrame.layer.cornerRadius = 30
        
        setupButtons()
    }
    
    func setupButtons() {
        followButton.setTitle(currentState?.buttonTitle, for: .normal)
        followButton.backgroundColor = currentState?.backgroundColor
        
        followButton.layer.cornerRadius = 7
        followButton.clipsToBounds = true
        
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func followButtonTapped() {
        switch currentState {
        case .follow:
            delegate?.unfollowTapped(data: followData!)
        case .unFollow:
            delegate?.followTapped(data: followData!)
        default:
            print("...")
        }
    }
    
    func setupUI() {
        self.contentView.addSubview(infoStack)
        self.contentView.addSubview(followButton)
        self.contentView.addSubview(moreImageView)
        self.contentView.addSubview(profileFrame)
        profileFrame.addSubview(profileImageView)
        
        _ = [idLabel, nameLabel].map({
            infoStack.addArrangedSubview($0)
        })
        
        profileFrame.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(contentView)
            $0.width.equalTo(profileFrame.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalTo(profileFrame).inset(3)
        }
        
        moreImageView.snp.makeConstraints {
            $0.trailing.top.bottom.equalTo(contentView)
            $0.width.equalTo(15)
        }
        
        followButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.trailing.equalTo(moreImageView.snp.leading).inset(-15)
            $0.centerY.equalTo(contentView)
        }
        
        infoStack.snp.makeConstraints {
            $0.leading.equalTo(profileFrame.snp.trailing).inset(-15)
            $0.trailing.equalTo(followButton.snp.leading).inset(-5)
            $0.centerY.equalTo(profileFrame.snp.centerY)
            $0.trailing.equalTo(followButton.snp.leading)
        }
    }
}
