//
//  FeedCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit

class FeedCell: UITableViewCell {
    
    var feedItem: Feed?
    
    // User
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    // 버튼
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    // 내용
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bodyIdLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // 기타
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupProfile()
        setupButtons(button: [likeButton, messageButton, sendButton, bookmarkButton])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    func setupButtons(button: [UIButton]) {
        button.forEach { button in
            button.setTitle("", for: .normal)
        }
    }
    
    func setupProfile() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func setupPageControl() {
        pageControl.backgroundStyle = .minimal
        pageControl.allowsContinuousInteraction = false
        pageControl.numberOfPages = feedItem?.media.count ?? 1
    }
    
    func configure() {
        if let item = feedItem {
            // User
            profileImageView.image = item.user.profileImage
            idLabel.text = item.user.id
            
            // 내용
            likeCountLabel.text = "좋아요 \(item.likeCount)개"
            bodyIdLabel.text = item.user.id
            bodyLabel.text = item.body
            commentCountLabel.text = "댓글 \(item.commentCount)개 모두 보기"
            setupCollectionView()
            setupPageControl()
        }
    }
    
    func setupCollectionView() {
        mediaCollectionView.register(FeedMediaCell.self, forCellWithReuseIdentifier: "FeedMediaCell")
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        
        mediaCollectionView.isPagingEnabled = true
        mediaCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItem?.media.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedMediaCell", for: indexPath) as? FeedMediaCell else { return UICollectionViewCell() }
        if let safeItems = feedItem {
            cell.imageName = safeItems.media[indexPath.row]
            cell.setupUI()
        }
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / self.frame.width)
        self.pageControl.currentPage = page
    }
}

extension FeedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Device.width
        let height = self.mediaCollectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
}
