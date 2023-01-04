//
//  ProfileViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/02.
//

import UIKit

class ProfileViewController: BaseViewController {
    
//    enum Section {
//        case upper
//        case lower
//    }
//    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
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
    
    private func setupData() {
        
        switch profileType {
        case .otherUserProfile:
            navigationItem.title = userId
            if let id = userIdx {
                dataManager.getProfileNetworkData(userIdx: id) { [weak self] result in
                    self?.profileItem = result
                    self?.profileCollectionView.reloadData()
                }
            }
        case .myProfile: // 임시
            dataManager.getProfileNetworkData(userIdx:3) { [weak self] result in
                self?.profileItem = result
                self?.setupUI(id: result.userId)
                self?.profileCollectionView.reloadData()
            }
        }

    }
    
    private func setupUI(id: String) {
        self.navigationItem.title = id
    }
    
//    private func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: profileCollectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
//
//            // Get a cell of the desired kind.
//
//            switch indexPath.section {
//            case 0:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInfoCell",
//                    for: indexPath) as? ProfileInfoCell else { fatalError("Cannot create new cell") }
//                return cell
//            default:
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell",
//                    for: indexPath) as? ContentsCell else { fatalError("ContentsCell") }
//                return cell
//            }
//        }
//        // initial data
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//        snapshot.appendSections([.upper, .lower])
//        snapshot.appendItems(Array(0..<5), toSection: .upper)
////        snapshot.appendItems(Array(0..<9), toSection: .lower)
//        dataSource.apply(snapshot, animatingDifferences: false)
//    }
    
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
}


