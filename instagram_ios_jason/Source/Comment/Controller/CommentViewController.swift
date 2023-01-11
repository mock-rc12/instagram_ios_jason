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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupData()
        setupMyProfile()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = 200
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
        ProfileDataManager().getProfileNetworkData(profileIdx: Secret.userIdx, userIdx: Secret.userIdx) { [weak self] result in
            if result.profileImg != nil || result.profileImg != "" {
                let url = URL(string: result.profileImg ?? "")
                self?.myProfileImageView.kf.setImage(with: url)
            } else {
                self?.myProfileImageView.image = UIImage(named: "default_profile")
            }
        }
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        if let item = postResult {
            let tempLabel = UILabel()
            tempLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            guard let comment = item.postContentRes else { return 0 }
            tempLabel.text = "\(comment[indexPath.row].reply ?? "") \(comment[indexPath.row].userId ?? "")"
            height += tempLabel.intrinsicContentSize.height + 50
            print(tempLabel.intrinsicContentSize.height)
            return height
        } else {
            return CGFloat(0)
        }
    }
}
