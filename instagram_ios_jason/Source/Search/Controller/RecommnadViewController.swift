//
//  RecommnadViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/11.
//

import UIKit

class RecommandViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var recommandDatas: [RecommandFeedResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupData()
        setupCollectionView()
    }
    
    func setupData() {
        SearchDataManager().getRecommandNetworkData { [weak self] result in
            for _ in 1...10 {
                result.forEach { result in
                    self?.recommandDatas.append(result)
                }
            }
            self?.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        collectionView.register(RecommandFeedCell.self, forCellWithReuseIdentifier: "RecommandFeedCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = generateLayout()
    }
    
    func generateLayout() -> UICollectionViewLayout {
    
        
        let mainItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)), subitem: pairItem, count: 2)
        
        let leftWithPairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [mainItem, trailingGroup, trailingGroup])
        
        let rightWithPairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [trailingGroup, trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(16/11)), subitems: [leftWithPairGroup, rightWithPairGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension RecommandViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandFeedCell", for: indexPath) as? RecommandFeedCell else { return UICollectionViewCell() }
        cell.recommandData = recommandDatas[indexPath.row]
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}
