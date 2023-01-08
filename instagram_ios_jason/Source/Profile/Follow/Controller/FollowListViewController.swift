//
//  FollowListViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/07.
//

import UIKit
import SnapKit

class FollowListViewController: BaseViewController {
    
    enum followType {
        case following
        case follower
    }
    var contentType: followType!
    var profileResult: ProfileResult!
    
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
        
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FollowListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
