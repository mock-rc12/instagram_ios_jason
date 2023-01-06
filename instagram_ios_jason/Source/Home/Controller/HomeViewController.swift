//
//  HomeViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit
import FacebookLogin
import YPImagePicker

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var homeFeedTableView: UITableView!
    
    var feedDatas: [Feed] = []
    
    var feedsData: [FeedsResult] = []
    
    let feedsDataManager = FeedsDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
        setupData()
        setupTableView()
        setupNavigationController()
    }
    
    private func checkLogin() {
        
        if let token = AccessToken.current, !token.isExpired {
            
        } else {
            let vc = UIStoryboard(name: "Login", bundle: .none).instantiateViewController(withIdentifier: "LoginNavigation")
            present(vc, animated: true)
        }
        //         임시
        //        let vc = UIStoryboard(name: "Login", bundle: .none).instantiateViewController(withIdentifier: "LoginNavigation")
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
    }
    
    private func setupData() {
        HomeDataManager.shared.fetchDummyData()
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        feedsDataManager.getFeedsNetworkData { [weak self] result in
            self?.feedsData = result
            self?.reloadTableView()
            IndicatorView.shared.dismiss()
        }
    }
    
    private func reloadTableView() {
        self.homeFeedTableView.dataSource = self
        self.homeFeedTableView.delegate = self
        self.homeFeedTableView.reloadData()
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
            self.addNewPost()
        }
        
        let titleItem = UIBarButtonItem.generate(config: titleConfig, width: 130)
        let messageItem = UIBarButtonItem.generate(config: messageConfig, width: itemSize)
        let notiItem = UIBarButtonItem.generate(config: notiConfig, width: itemSize)
        let postItem = UIBarButtonItem.generate(config: postConfig, width: itemSize)
        let spacingItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        spacingItem.width = spacing
        
        navigationItem.leftBarButtonItem = titleItem
        navigationItem.rightBarButtonItems = [messageItem, spacingItem, notiItem, spacingItem, postItem]
    }
    
    //MARK: - 게시글 올리기 뷰 불러오기
    func addNewPost() {
        var config = YPImagePickerConfiguration()
        config.startOnScreen = .library
        config.screens = [.photo, .library]
        config.library.maxNumberOfItems = 10
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            var images: [UIImage] = []
            for item in items {
                switch item {
                case .photo(let photo):
                    images.append(photo.image)
                default:
                    print("흥")
                }
            }
            guard let vc = UIStoryboard(name: "PostEdit", bundle: nil).instantiateViewController(withIdentifier: "PostEditViewController") as? PostEditViewController else { return }
            vc.selectedImage = images
            vc.delegate = self
            picker.pushViewController(vc, animated: true)
            
            
            if cancelled == true {
                picker.dismiss(animated: true, completion: nil)
            }
        }
        picker.modalTransitionStyle = .coverVertical
        present(picker, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableCell", for: indexPath) as? StoryTableCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { return UITableViewCell() }
            cell.feedsItem = feedsData[indexPath.row - 1]
            cell.configure()
            cell.delegate = self
            cell.mediaCollectionView.reloadData()
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

extension HomeViewController: HomeVCDelegate {
    func feedUploadSuccessed() {
        print(#function)
        setupData()
    }
    
    func likeCountLabelTapped() {
        guard let vc = UIStoryboard(name: "LikeList", bundle: .none).instantiateViewController(withIdentifier: "LikeListViewController") as? LikeListViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func commentCountLabelTapped() {
        
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
    
    func moreImageTapped(userIdx: Int) {
        let sheet = BottomSheetViewController()
        sheet.bottomHeight = 500
        sheet.modalPresentationStyle = .overFullScreen
        if userIdx == Secret.userIdx {
            sheet.feedType = .myProfile
        } else {
            sheet.feedType = .otherUserProfile
        }
        self.present(sheet, animated: false)
    }
}
