//
//  CommentViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/10.
//

import UIKit
import Kingfisher

class CommentViewController: UIViewController {
    
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var postIdx: Int!
    var userIdx: Int!
    var postResult: PostResult?
    let dataManager = PostDataManager()
    
    var textFieldBtn: UIButton = {
        let button = UIButton()
        button.setTitle("게시", for: .normal)
        button.tintColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.backgroundColor = .clear

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupData()
        setupMyProfile()
        setupTextField()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupUI() {
        setupMyProfile()
        self.navigationItem.title = "댓글"
    }
    
    func setupData() {
        dataManager.getPostNetworkData(idx: postIdx) { [weak self] result in
            self?.postResult = result
            self?.tableView.reloadData()
            dump(result)
        }
    }
    
    func setupMyProfile() {
        // 기본 이미지
        self.myProfileImageView.image = UIImage(named: "default_profile")
        myProfileImageView.layer.cornerRadius = myProfileImageView.frame.height / 2
        myProfileImageView.clipsToBounds = true
        
        ProfileDataManager().getProfileNetworkData(profileIdx: Secret.userIdx, userIdx: Secret.userIdx) { [weak self] result in
            if result.profileImg != nil || result.profileImg != "" {
                let url = URL(string: result.profileImg ?? "")
                self?.myProfileImageView.kf.setImage(with: url)
            }
        }
    }
    
    func setupTextField() {
        commentTextField.delegate = self
        textFieldBtn.addTarget(self, action: #selector(uploadComment), for: .touchUpInside)
        commentTextField.rightView = textFieldBtn
        commentTextField.rightViewMode = .whileEditing
    }


    @objc func uploadComment() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        let comment = commentTextField.text
        if comment != nil && comment != "" {
            guard let post = postResult else { return }
            let model = CommentDataModel(reply: comment!, depth: 0, commentAIdx: 0)
            CommentDataManasger().commentNetworkData(userIdx: Secret.userIdx, postIdx: post.postIdx, param: model) { [weak self] isSuccess in
                if isSuccess == true {
                    IndicatorView.shared.dismiss()
                    self?.setupData()
                }
            }
        } else {
            IndicatorView.shared.dismiss()
            ToastNoti.showToast("댓글을 입력해주세요", withDuration: 1.5, delay: 1, vc: self)
        }
        commentTextField.text = ""
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postResult?.postContentRes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { return UITableViewCell() }
        if let data = postResult {
            cell.comment = data.postContentRes?[indexPath.row]
            cell.configure()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let item = postResult {
            let label: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.frame.width - 70, CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byTruncatingTail
            label.font = .systemFont(ofSize: 15, weight: .regular)
            
            guard let comment = item.postContentRes?[indexPath.row] else { return 0 }
            
            label.text = "\(comment.userId ?? "")  \(comment.reply ?? "")"
            label.sizeToFit()
            
            return label.frame.height + 50
        } else {
            return 0
        }
    }
}

extension CommentViewController: UITextFieldDelegate {
    
}
