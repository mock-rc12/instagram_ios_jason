//
//  FollowListViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/07.
//

import UIKit
import SnapKit

protocol FollowStateDelegate {
    func followTapped(data: FollowResult)
    func unfollowTapped(data: FollowResult)
}

struct FollowConfig {
    var followResult: ProfileResult
    var type: UserListViewController.FollowType
}

struct LikeConfig {
    var post: FeedsResult
}

class UserListViewController: BaseViewController {
    
    enum PageType {
        case follow
        case like
    }
    
    enum FollowType {
        case following
        case follower
    }
    
    var pageType: PageType?
    
    // 좋아요
    var postResult: FeedsResult?
    var likeLists: [LikeListResult] = []
    
    // 팔로우
    var followContentType: FollowType?
    var profileResult: ProfileResult?
    var followData: [FollowResult] = []
    let dataManager = FollowDataManager()
    
    var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        return view
    }()
    
    init(pageType: PageType, followConfig: FollowConfig?, likeConfig: LikeConfig?) {
        super.init(nibName: nil, bundle: nil)
        self.pageType = pageType
        switch pageType {
        case .follow:
            self.followContentType = followConfig?.type
            self.profileResult = followConfig?.followResult
        case .like:
            self.postResult = likeConfig?.post
        }
        setupData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func setupData() {
        
        switch pageType {
        case .follow:
            dataManager.getFollowNetworkData(type: followContentType!, userIdx: profileResult!.userIdx) { [weak self] resultArray in
                self?.followData = resultArray
                self?.tableView.reloadData()
            }
        case .like:
            if let post = postResult {
                LikeListDataManager().likeUserListNetworkData(userIdx: Secret.userIdx, postIdx: post.postIdx) { [weak self] result in
                    self?.likeLists = result
                    self?.likeDataTrans(data: result)
                    self?.tableView.reloadData()
                }
            }
            self.navigationItem.title = "좋아요"
        default:
            print("")
        }
    }
    
    func likeDataTrans(data: [LikeListResult]) {
        var defaultItem: [FollowResult] = []
        data.forEach {
            defaultItem.append(FollowResult(userIdx: $0.userIdx, name: $0.userId, profileImg: $0.profileImg, id: $0.userId, status: "0", followYn: $0.followStatus))
        }
        followData = defaultItem
    }
    
    func setupTableView() {
        tableView.register(FollowCell.self, forCellReuseIdentifier: "FollowCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.allowsSelection = false
    }
    
    func followReq(data: FollowResult, type: String) {
        ProfileDataManager().followReqNetworkData(param: FollowReqModle(followIdx: data.userIdx, status: type), idx: Secret.userIdx) { [weak self] isSuccess in
            if isSuccess == true {
                print("성공 !!!")
                self?.setupData()
            } else {
                print("실패 !!!")
            }
        }
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowCell", for: indexPath) as? FollowCell else { return UITableViewCell() }
        
        cell.followData = followData[indexPath.row]
        cell.delegate = self
        cell.configure()
        return cell
    }
}

extension UserListViewController: FollowStateDelegate {
    func followTapped(data: FollowResult) {
        followReq(data: data, type: "ACTIVE")
    }
    
    func unfollowTapped(data: FollowResult) {
        followReq(data: data, type: "INACTIVE")
    }
}
