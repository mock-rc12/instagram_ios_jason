//
//  FollowViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/07.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

class FollowViewController: TabmanViewController {
    
    var profileType: ProfileType!
    var profile: ProfileResult?
    
    var pageType: UserListViewController.FollowType?
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupBar()
        self.dataSource = self
    }
    
    func setupVC() {
        
        if let data = profile {
            let followingConfig = FollowConfig(followResult: data, type: .following)
            let followingVC = UserListViewController(pageType: .follow, followConfig: followingConfig, likeConfig: nil)
            
            let followerConfig = FollowConfig(followResult: data, type: .follower)
            let followerVC = UserListViewController(pageType: .follow, followConfig: followerConfig, likeConfig: nil)
        
            switch profileType {
            case .myProfile:
                viewControllers = [followingVC, followerVC]
            case .otherUserProfile:
                let followTogetherConfig = FollowConfig(followResult: data, type: .followTogether)
                let followTogetherVC = UserListViewController(pageType: .follow, followConfig: followTogetherConfig, likeConfig: nil)
                viewControllers = [followTogetherVC, followingVC, followerVC]
            case .none:
                print("")
            }
            self.navigationItem.title = data.userId
        }
    }
    
    private func setupBar() {
        self.view.backgroundColor = .clear
        let bar = TMBar.ButtonBar()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .snap
        addBar(bar, dataSource: self, at: .top)
        bar.indicator.weight = .light
        bar.backgroundView.style = .clear
        bar.indicator.tintColor = .label
        bar.buttons.customize { button in
            button.selectedTintColor = .label
            button.backgroundColor = .clear
            button.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//            button.tintColor = .gray
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .bold)
            button.selectedTintColor = .label
        }
    }
}

extension FollowViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        if profile != nil {
            
            switch profileType {
                // 다른사람 프로필일 때
            case .otherUserProfile:
                switch index {
                case 0:
                    return TMBarItem(title: "함께 아는 친구")
                case 1:
                    return TMBarItem(title: "팔로워")
                case 2:
                    return TMBarItem(title: "팔로잉")
                default:
                    let title = "Page \(index)"
                    return TMBarItem(title: title)
                }
                // 내 프로필일 때
            default:
                switch index {
                case 0:
                    return TMBarItem(title: "팔로워")
                case 1:
                    return TMBarItem(title: "팔로잉")
                default:
                    let title = "Page \(index)"
                    return TMBarItem(title: title)
                }
            }
        } else {
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return self.viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return self.viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        
        switch profileType {
        case .otherUserProfile:
            switch pageType {
            case .followTogether:
                return .first
            case .follower:
                return .at(index: 1)
            case .following:
                return .last
            default:
                return .none
            }
        case .myProfile:
            switch pageType {
            case .follower:
                return .first
            case .following:
                return .last
            default:
                return .none
            }
        default:
            return .none
        }
    }
    
}
