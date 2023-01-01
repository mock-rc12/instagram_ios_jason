//
//  StoryTableCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class StoryTableCell: UITableViewCell {
    
    let dataManager = HomeDataManager.shared
    
    var storyData: [Profile] = []

    @IBOutlet weak var storyCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupData()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setupData() {
        storyData = dataManager.getStoryDummyData()
    }
    
    private func setupCollectionView() {
        storyCollectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        
        flowLayout.minimumInteritemSpacing = 10
        
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        
        storyCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func getStoryCell(index: IndexPath) -> StoryCell {
        guard let cell = storyCollectionView.cellForItem(at: index) as? StoryCell else { return StoryCell() }
        return cell
    }
}

extension StoryTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 스토리 데이터 + 나
        return storyData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            cell.isMyStory = true
            cell.isMyStoryEmpty = true
            cell.item = UserModel.myProfile
        } else {
            cell.item = storyData[indexPath.row - 1]
        }
        cell.setupUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getStoryCell(index: indexPath).isStoryRead = true
    }
}

extension StoryTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        
        let height = self.frame.height
        let width = (self.frame.width - (flow.minimumInteritemSpacing * 4)) / 4.5
        
        return CGSize(width: width, height: height)
    }
}
