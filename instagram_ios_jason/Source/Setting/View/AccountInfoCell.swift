//
//  AccountInfoCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit

class AccountInfoCell: UITableViewCell {
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "로그인"
        return label
    }()
    
    var addAcountButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .clear
        button.setTitleColor( #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1), for: .normal)
        button.setTitle("계정 추가", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(nil, action: #selector(addAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .clear
        button.setTitleColor( #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1), for: .normal)
        button.setTitle("계정 추가", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(nil, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.contentView.addSubview(stackView)
        _ = [loginLabel, addAcountButton, logoutButton].map({
            stackView.addArrangedSubview($0)
        })
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ProfileDataManager().getProfileNetworkData(profileIdx: Secret.userIdx, userIdx: Secret.userIdx) { [weak self] profile in
            
            self?.logoutButton.setTitle("\(profile.userId) 로그아웃", for: .normal)
        }
    }
    
    @objc func addAccountButtonTapped() {
        print(#function)
    }
    
    @objc func logoutButtonTapped() {
        print(#function)
    }
}
