//
//  HomeViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var homeFeedTableView: UITableView!
    
    var feedDatas: [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupTableView()
        setupNavigationController()
    }
    
    private func setupData() {
        HomeDataManager.shared.fetchDummyData()
        feedDatas = HomeDataManager.shared.getFeedData()
    }
    
    private func setupTableView() {
        self.homeFeedTableView.register(UINib(nibName: "StoryTableCell", bundle: nil), forCellReuseIdentifier: "StoryTableCell")
        self.homeFeedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.homeFeedTableView.dataSource = self
        self.homeFeedTableView.delegate = self
        self.homeFeedTableView.allowsSelection = false
        self.homeFeedTableView.showsVerticalScrollIndicator = false
        self.homeFeedTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    //MARK: - 네비게이션 컨트롤러 설정
    private func setupNavigationController() {
        let itemSize = CGFloat(35)
        let spacing = CGFloat(15)
        
        let titleConfig = CustomNaviBarItemConfig(image: UIImage(named: "instagram_logo")) {
            print("타이틀 버튼 눌림")
        }
        
        let messageConfig = CustomNaviBarItemConfig(image: UIImage(systemName: "paperplane")) {
            print("DM버튼 눌림")
        }
        
        let notiConfig = CustomNaviBarItemConfig(image: UIImage(systemName: "heart")) {
            print("알림 버튼 눌림")
        }
        
        let postConfig = CustomNaviBarItemConfig(image: UIImage(systemName: "plus.app")) {
            print("포스트 버튼 눌림")
        }
        
        let titleItem = UIBarButtonItem.generate(config: titleConfig, width: 130)
        let messageItem = UIBarButtonItem.generate(config: messageConfig, width: itemSize)
        let notiItem = UIBarButtonItem.generate(config: notiConfig, width: itemSize)
        let postItem = UIBarButtonItem.generate(config: postConfig, width: itemSize)
        let spacingItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        spacingItem.width = spacing
        
        navigationItem.leftBarButtonItem = titleItem
        navigationItem.rightBarButtonItems = [messageItem, spacingItem, notiItem, spacingItem, postItem]
        
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedDatas.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableCell", for: indexPath) as? StoryTableCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { return UITableViewCell() }
            cell.feedItem = feedDatas[indexPath.row - 1]
            cell.configure()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 115
        default:
            return Device.width + 185
        }
    }
}
