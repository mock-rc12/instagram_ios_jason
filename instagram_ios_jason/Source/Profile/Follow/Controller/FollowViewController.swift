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
            viewControllers = [followerVC, followingVC]
        }
    }
    
    private func setupBar() {
        let bar = TMBar.ButtonBar()
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .snap
        addBar(bar, dataSource: self, at: .top)
        bar.indicator.weight = .medium
        bar.backgroundView.style = .blur(style: .light)
        bar.indicator.tintColor = #colorLiteral(red: 0.4356632233, green: 0.4757905006, blue: 0.968429029, alpha: 1)
        bar.buttons.customize { button in
            button.selectedTintColor = #colorLiteral(red: 0.4356632233, green: 0.4757905006, blue: 0.968429029, alpha: 1)
            button.backgroundColor = .clear
            button.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        }
    }
}

extension FollowViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        if let data = profile {
            switch index {
            case 0:
                return TMBarItem(title: "\(data.followerCount) 팔로워")
            case 1:
                return TMBarItem(title: "\(data.followingCount) 팔로잉")
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
        return nil
    }
    
}
