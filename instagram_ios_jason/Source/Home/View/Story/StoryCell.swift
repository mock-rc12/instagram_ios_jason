//
//  StoryCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class StoryCell: UICollectionViewCell {
    var item: Profile?
    
    var isMyStory: Bool = false // 내 스토리
    var isMyStoryEmpty: Bool = false // 내 스토리 추가한 것 없음
    var isStoryRead: Bool = false {
        didSet {
            storyReadCheck()
        }
    }
    
    var newStoryView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var addIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "addButton")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var storyPadding = CGFloat(3)
    
    func setupUI() {
        
        self.contentView.addSubview(newStoryView)
        self.contentView.addSubview(nameLabel)
        newStoryView.addSubview(profileImageView)

        setupConstraints()
        if isMyStory == true && isMyStoryEmpty == true {
            self.contentView.addSubview(addIcon)
            self.setupAddIconConstraints()
        }
        configure()
        imageToRound()
        storyReadCheck()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newStoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newStoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newStoryView.topAnchor.constraint(equalTo: self.topAnchor),
            newStoryView.heightAnchor.constraint(equalToConstant: self.frame.width),
            
            profileImageView.leadingAnchor.constraint(equalTo: newStoryView.leadingAnchor, constant: storyPadding),
            profileImageView.trailingAnchor.constraint(equalTo: newStoryView.trailingAnchor, constant: -storyPadding),
            profileImageView.topAnchor.constraint(equalTo: newStoryView.topAnchor, constant: storyPadding),
            profileImageView.bottomAnchor.constraint(equalTo: newStoryView.bottomAnchor, constant: -storyPadding),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: newStoryView.bottomAnchor, constant: 5),
        ])
    }
    
    private func setupAddIconConstraints() {
        NSLayoutConstraint.activate([
            addIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addIcon.bottomAnchor.constraint(equalTo: newStoryView.bottomAnchor),
            addIcon.widthAnchor.constraint(equalToConstant: self.frame.width * 0.4),
//            addIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            addIcon.heightAnchor.constraint(equalToConstant: self.frame.width * 0.4)
        ])
    }
    
    private func configure() {
        
        if let safeItem = item {
            profileImageView.image = safeItem.profileImage
            if isMyStory == true {
                nameLabel.text = "내 스토리"
            } else {
                nameLabel.text = safeItem.id
            }
        }
    }
    
    private func storyReadCheck() {
        
        if isMyStory == true {
            // 스토리 업로드한게 없으면
            if isMyStoryEmpty == true {
                emptyStory()
            }
        } else {
            // 스토리를 읽지 않았다면
            if isStoryRead == false {
                newStory()
            } else {
                emptyStory()
            }
        }
    }
    
    private func emptyStory() {
        newStoryView.image = nil
        if isMyStory == true {
            newStoryView.backgroundColor = .clear
        } else {
            newStoryView.backgroundColor = .gray
        }
    }
    
    private func newStory() {
        newStoryView.image = UIImage(named: "storyBackground")
        newStoryView.backgroundColor = .clear
    }
    
    private func imageToRound() {
        profileImageView.layer.cornerRadius = (self.frame.width - storyPadding * 2) / 2
        newStoryView.layer.cornerRadius = self.frame.width / 2
        
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.systemBackground.cgColor
        
        profileImageView.clipsToBounds = true
        newStoryView.clipsToBounds = true
        
        if isMyStory == true && isMyStoryEmpty == true {
            addIcon.layer.cornerRadius = (self.frame.width * 0.4) / 2
            addIcon.clipsToBounds = true
            addIcon.layer.borderWidth = 2
            addIcon.layer.borderColor = UIColor.systemBackground.cgColor
        }
    }
}
