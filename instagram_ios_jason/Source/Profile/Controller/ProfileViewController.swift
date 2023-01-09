//
//  ProfileViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    enum followReqType {
        case follow
        case followCancel
    }
    
    var profileType: ProfileType = .myProfile

    var userIdx: Int?
    var userId: String?
    let dataManager = ProfileDataManager()
    var profileItem: ProfileResult?
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        profileCollectionView.register(UINib(nibName: "ProfileInfoCell", bundle: nil), forCellWithReuseIdentifier: "ProfileInfoCell")
        profileCollectionView.register(UINib(nibName: "ContentsCell", bundle: nil), forCellWithReuseIdentifier: "ContentsCell")
        profileCollectionView.register(UINib(nibName: "ProfileTabHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileTabHeaderView")
        
        setupCollectionView()
    }
    
    func setupData() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
        switch profileType {
        case .otherUserProfile:
            navigationItem.title = userId
            if let id = userIdx {
                dataManager.getProfileNetworkData(profileIdx: id, userIdx: Secret.userIdx) { [weak self] result in
                    IndicatorView.shared.dismiss()
                    self?.profileItem = result
                    self?.profileCollectionView.reloadData()
                }
            }
        case .myProfile: // 임시
            dataManager.getProfileNetworkData(profileIdx: Secret.userIdx, userIdx: Secret.userIdx) { [weak self] result in
                IndicatorView.shared.dismiss()
                self?.profileItem = result
                self?.setupUI(id: result.userId)
                self?.profileCollectionView.reloadData()
            }
        }
    }
    
    private func setupUI(id: String) {
        self.navigationItem.title = id
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupCollectionView() {
        profileCollectionView.collectionViewLayout = layoutSet()
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
    }
    
    func layoutSet() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.upperSection()
            default:
                return self.lowerSection()
            }
        }
    }
    
    func upperSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(270))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func lowerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemInset = CGFloat(1)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func followButtonAction(action: followReqType) {

        if let profile = profileItem {
            var status = ""
            
            switch action {
            case .follow:
                status = "ACTIVE"
                print("REQUEST: 요청")
            case .followCancel:
                status = "INACTIVE"
                print("REQUEST: 취소")
            }
            
            let param = FollowReqModle(followIdx: profile.userIdx, status: status)
            dataManager.followReqNetworkData(param: param, idx: Secret.userIdx) { [weak self] isSuccess in
                self?.setupData()
            }
        }
    }
    
    func presentFollowVC(type: FollowListViewController.followType) {
        let vc = FollowViewController()
        vc.profile = profileItem!
        vc.pageType = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


