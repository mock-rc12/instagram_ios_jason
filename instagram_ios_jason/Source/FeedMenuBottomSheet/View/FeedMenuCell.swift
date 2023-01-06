//
//  FeedMenuCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import UIKit

class FeedMenuCell: UITableViewCell {
    
    var menu: FeedMenuModel?
    var inset: CGFloat = 10
    
    var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .label
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = inset + 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure() {
        self.backgroundColor = #colorLiteral(red: 0.2117646933, green: 0.2117646933, blue: 0.2117646933, alpha: 1)
        self.addSubview(stackView)
        _ = [icon, titleLabel].map({
            stackView.addArrangedSubview($0)
        })
        setupConstraints()
        
        if let item = menu {
            icon.image = item.icon
            titleLabel.text = item.title
        }
        
        if menu?.myType == .deleteFeed || menu?.otherType == .report {
            icon.tintColor = .red
            titleLabel.textColor = .red
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor, constant: -25)
        ])
    }
}
