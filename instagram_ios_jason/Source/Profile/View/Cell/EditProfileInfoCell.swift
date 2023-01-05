//
//  EditProfileInfoCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit

class EditProfileInfoCell: UITableViewCell {
    
    var initData: ProfileResult?
    var editType: EditType!
    
    var infoTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fieldText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
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
    
    override func prepareForReuse() {
        infoTitle.text = ""
        fieldText.text = ""
        infoTitle.textColor = .label
        fieldText.textColor = .label
        
        infoTitle.removeFromSuperview()
        fieldText.removeFromSuperview()
    }
    
    func setupUI() {
        dump(initData)
        switch editType {
        case .profileImage:
            print("")
        case .name:
            setTextField()
            infoTitle.text = "이름"
            fieldText.text = initData?.name
        case .id:
            setTextField()
            infoTitle.text = "사용자 이름"
            fieldText.text = initData?.userId
        case .introduction:
            setTextField()
            infoTitle.text = "소개"
            fieldText.text = initData?.introduction
        case .website:
            setTextField()
            infoTitle.text = "링크"
            fieldText.text = initData?.website
        case .transitionToProfessional:
            setTransitionMenu()
            infoTitle.text = "프로페셔널 계정으로 전환"
            infoTitle.textColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
        case .privateSetting:
            setTransitionMenu()
            infoTitle.text = "개인정보 설정"
            infoTitle.textColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
        case .none:
            print("")
        }
    }
    
    func setTextField() {
        self.addSubview(labelStack)
        setStackConstraints(isTextField: true)
        _ = [infoTitle, fieldText].map({
            labelStack.addArrangedSubview($0)
        })
    }
    
    func setTransitionMenu() {
        self.addSubview(labelStack)
        setStackConstraints(isTextField: false)
        _ = [infoTitle].map({
            labelStack.addArrangedSubview($0)
        })
    }
    
    func setStackConstraints(isTextField: Bool) {
        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            labelStack.topAnchor.constraint(equalTo: self.topAnchor),
            labelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        if isTextField == true {
            infoTitle.widthAnchor.constraint(equalToConstant: 120).isActive = true
        }
    }

}
