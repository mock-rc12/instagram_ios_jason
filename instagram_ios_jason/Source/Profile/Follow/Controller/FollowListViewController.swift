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

class FollowListViewController: BaseViewController {
    
    enum followType {
        case following
        case follower
    }
    
    var contentType: followType!
    var profileResult: ProfileResult!
    let dataManager = FollowDataManager()
    var followData: [FollowResult] = []
    
    var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        return view
    }()
    
    init(result: ProfileResult, type: followType) {
        super.init(nibName: nil, bundle: nil)
        self.contentType = type
        self.profileResult = result
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupTableView()
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func setupData() {
        dataManager.getFollowNetworkData(type: contentType, userIdx: profileResult.userIdx) { [weak self] resultArray in
            print("Result ==")
            print(resultArray)
            self?.followData = resultArray
            self?.tableView.reloadData()
        }
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

extension FollowListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowCell", for: indexPath) as? FollowCell else { return UITableViewCell() }
        cell.contentType = contentType
        cell.delegate = self
        cell.followData = followData[indexPath.row]
        cell.configure()
        return cell
    }
}

extension FollowListViewController: FollowStateDelegate {
    func followTapped(data: FollowResult) {
        followReq(data: data, type: "ACTIVE")
    }
    
    func unfollowTapped(data: FollowResult) {
        followReq(data: data, type: "INACTIVE")
    }
}
