//
//  PostViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    
    var selectedIndex: IndexPath?
    var postResults: [PostResult]?
    var postValues: [Int] = []
    var selectedPostIdx: Int?
    
    let dataManager = PostDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupTableView()
    }
    
    func setupData() {
        dataManager.getPostNetworkData(idx: selectedPostIdx ?? 0) { [weak self] result in
            self?.postResults = []
            self?.postResults?.append(result)
            self?.postTableView.reloadData()
        }
    }
    
    func setupTableView() {
        postTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.rowHeight = self.view.frame.height
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { return UITableViewCell() }
        
        if let result = postResults {
            let data = result[indexPath.row]
            let item = FeedsResult(postIdx: data.postIdx, content: data.content, userIdx: data.userIdx, userId: data.userId, profileImgUrl: data.profileImgUrl, postLikeCount: data.postLikeCount, commentCount: data.postContentRes?.count ?? 0, updateAt: data.updateAt, postImgRes: data.postImgRes)
            cell.delegate = self
            cell.feedsItem = item
            cell.configure()
        }
        
        return cell
    }
}

extension PostViewController: HomeVCDelegate {
    func likeCountLabelTapped() {
        print(#function)
    }
    
    func commentCountLabelTapped() {
        print(#function)
    }
    
    func userIdLabelTapped(user: FeedsResult) {
        print(#function)
    }
    
    func moreImageTapped() {
        print(#function)
    }
    
    func feedUploadSuccessed() {
        print(#function)
    }
}
