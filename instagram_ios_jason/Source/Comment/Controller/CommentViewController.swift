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
        tableView.rowHeight = 200
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
}
