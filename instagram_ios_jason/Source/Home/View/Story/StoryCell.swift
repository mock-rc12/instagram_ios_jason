//
//  StoryCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    var newStoryView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var storyPadding = CGFloat(2)
    
    override func prepareForReuse() {
        configure()
    }
    
    func setupUI() {
        
        self.contentView.addSubview(newStoryView)
        self.contentView.addSubview(nameLabel)
        newStoryView.addSubview(profileImageView)
        
        setupConstraints()
        configure()
        imageToRound()
    }
    
    func setupConstraints() {
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
            nameLabel.topAnchor.constraint(equalTo: newStoryView.bottomAnchor, constant: 1),
        ])
    }
    
    func configure() {
        newStoryView.image = UIImage(named: "storyBackground")
        profileImageView.image = UIImage(named: "dummyProfile")
        nameLabel.text = "jason_kim"
    }
    
    func imageToRound() {
        profileImageView.layer.cornerRadius = (self.frame.width - storyPadding * 2) / 2
        newStoryView.layer.cornerRadius = self.frame.width / 2
        
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.systemBackground.cgColor
        
        profileImageView.clipsToBounds = true
        newStoryView.clipsToBounds = true
    }
}
