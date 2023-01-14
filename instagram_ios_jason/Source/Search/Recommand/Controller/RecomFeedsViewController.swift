//
//  RecomFeedsViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class RecomFeedsViewController: BaseViewController {
    
    var selectedPostIdx: Int
    
    var feedsResult: [FeedsResult] = []
    
    var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        return table
    }()
    
    init(postIdx: Int) {
        self.selectedPostIdx = postIdx
        super.init(nibName: nil, bundle: nil)
        setupDatas()
        setupTableView()
        self.navigationItem.title = "추천 게시글"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupDatas() {
        print("selected: \(selectedPostIdx)")
        RecommandDataManager().getRecomFeedsNetworkData(postIdx: selectedPostIdx) { [weak self] result in
            self?.feedsResult = result
            self?.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Device.width + 185
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension RecomFeedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { print("이거 왜 안돼"); return UITableViewCell() }
        cell.feedsItem = feedsResult[indexPath.row]
        cell.delegate = self
        cell.configure()
        return cell
    }
}

extension RecomFeedsViewController: HomeVCDelegate {
    func likeCountLabelTapped(item: FeedsResult) {
        let config = LikeConfig(post: item)
        let vc = UserListViewController(pageType: .like, followConfig: nil, likeConfig: config)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func commentCountLabelTapped(user: FeedsResult) {
        guard let vc = UIStoryboard(name: "Comment", bundle: nil).instantiateViewController(withIdentifier: "CommentViewController") as? CommentViewController else { return }
        vc.userIdx = user.userIdx
        vc.postIdx = user.postIdx
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func userIdLabelTapped(user: FeedsResult) {
        guard let vc = UIStoryboard(name: "Profile", bundle: .none).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        vc.userIdx = user.userIdx
        vc.userId = user.userId
        if user.userIdx == Secret.userIdx {
            vc.profileType = .myProfile
        } else {
            vc.profileType = .otherUserProfile
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moreImageTapped(item: FeedsResult) {
        let sheet = BottomSheetViewController()
        
        sheet.modalPresentationStyle = .overFullScreen
        if item.userIdx == Secret.userIdx {
            sheet.feedType = .myProfile
            sheet.bottomHeight = self.view.frame.height * 0.9
        } else {
            sheet.feedType = .otherUserProfile
            sheet.bottomHeight = self.view.frame.height * 0.7
        }
        sheet.delegate = self
        sheet.feedInfo = item
        self.present(sheet, animated: false)
    }
    
    func feedUploadSuccessed() {
        print(#function)
        setupDatas()
    }
    
    func feedModifySuccessed() {
        print(#function)
        setupDatas()
    }
    
    func likeButtonTapped(data: FeedsResult) {
        PostDataManager().likeNetworkData(userIdx: Secret.userIdx, postIdx: data.postIdx) { [weak self] isSuccess in
            if isSuccess == true {
                self?.setupDatas()
            }
        }
    }
    
    func shareButtonTapped() {
        print(#function)
    }
    
    func messageButtonTapped() {
        print(#function)
    }
}

extension RecomFeedsViewController: FeedMenuDelegate {
    func deleteDone() {
        setupDatas()
    }
    
    func modifyTapped(feeds: FeedsResult) {
        guard let vc = UIStoryboard(name: "PostEdit", bundle: nil).instantiateViewController(withIdentifier: "PostEditViewController") as? PostEditViewController else { return }
        vc.post = feeds
        vc.editType = .modify
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
