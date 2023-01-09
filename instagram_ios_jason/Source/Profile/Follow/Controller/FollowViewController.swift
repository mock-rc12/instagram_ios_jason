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
    
    var pageType: FollowListViewController.followType?
    var profile: ProfileResult?
    var viewControllers: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupBar()
        self.dataSource = self
    }
    
    func setupVC() {
        
        if let data = profile {
            let followingVC = FollowListViewController(result: data, type: .following)
            let followerVC = FollowListViewController(result: data, type: .follower)
            viewControllers = [followingVC, followerVC]
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
            switch index {
            case 0:
                return TMBarItem(title: "팔로워")
            case 1:
                return TMBarItem(title: "팔로잉")
            default:
                let title = "Page \(index)"
                return TMBarItem(title: title)
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
        
        if pageType == .follower {
            return .first
        } else {
            return .last
        }
    }
    
}
