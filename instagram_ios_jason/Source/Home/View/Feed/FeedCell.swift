//
//  FeedCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/01.
//

import UIKit
import Kingfisher

class FeedCell: UITableViewCell {
    
    enum LikeStatus {
        case likeY
        case likeN
        
        var likeImage: UIImage? {
            switch self {
            case .likeN:
                return UIImage(systemName: "heart")
            case .likeY:
                return UIImage(systemName: "heart.fill")
            }
        }
        
        var likeColor: UIColor {
            switch self {
            case .likeN:
                return UIColor.label
            case .likeY:
                return UIColor.red
            }
        }
    }
    
    var feedsItem: FeedsResult?
    var delegate: HomeVCDelegate?
    var likeStatus: LikeStatus? {
        didSet {
            if likeStatus == .likeY {
                likeEnableUI()
            } else if likeStatus == .likeN {
                likeDisableUI()
            }
        }
    }
    
    // User
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    
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
    
    override func prepareForReuse() {
        likeDisableUI()
    }
    
    func setupButtons(button: [UIButton]) {
        button.forEach { button in
            button.setTitle("", for: .normal)
        }
    }
    
    func likeCheck() {
        if let item = feedsItem {
            LikeListDataManager().likeUserListNetworkData(userIdx: Secret.userIdx, postIdx: item.postIdx) { result in
                dump(result)
                result.forEach { [weak self] item in
                    if Secret.userIdx == item.userIdx {
                        self?.likeStatus = .likeY
                    }
                }
            }
        }
    }
    
    func likeEnableUI() {
        likeButton.tintColor = LikeStatus.likeY.likeColor
        likeButton.setImage(LikeStatus.likeY.likeImage, for: .normal)
    }
    
    func likeDisableUI() {
        likeButton.tintColor = LikeStatus.likeN.likeColor
        likeButton.setImage(LikeStatus.likeN.likeImage, for: .normal)
    }
    
    func setupProfile() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func setupPageControl() {
        pageControl.backgroundStyle = .minimal
        pageControl.allowsContinuousInteraction = false
        pageControl.numberOfPages = feedsItem?.postImgRes?.count ?? 1
    }
    
    func configure() {
        if let item = feedsItem {
            // User
            kingfisher()
            idLabel.text = item.userId
            
            // 내용
            likeCountLabel.text = "좋아요 \(item.postLikeCount)개"
            bodyLabel.text = "\(item.content)"
            bodyIdLabel.text = item.userId
            timeLabel.text = item.updateAt
            
            // 댓글 개수
            if item.commentCount != 0 {
                commentCountLabel.text = "댓글 \(item.commentCount ?? 0)개 모두보기"
            } else {
                commentCountLabel.text = ""
            }
            
            setupCollectionView()
            setupPageControl()
            
            // 제스쳐 셋업
            setupGesture(view: [idLabel, likeCountLabel, commentCountLabel, bodyLabel, profileImageView, moreImageView, bodyIdLabel])
        }
        
        likeCheck()
    }
    
    func kingfisher() {
        
        if let item = feedsItem {
            
            let url = URL(string: item.profileImgUrl ?? "")
            let processor = DownsamplingImageProcessor(size: profileImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
            profileImageView.kf.indicatorType = .activity
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "default_profile"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                    self.profileImageView.image = UIImage(named: "default_profile")
                }
            }
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
    
    func setupGesture(view: [UIView]) {
        view.forEach { view in
            view.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
            view.addGestureRecognizer(gesture)
        }
    }
    
    // MARK: - 유저 인터랙션 정의 ⭐️
    @objc private func buttonTapped(_ sender: UITapGestureRecognizer) {
        guard let item = feedsItem else { return }
        switch sender.view {
        case idLabel, bodyIdLabel:
            print("유저 아이디 눌림")
            delegate?.userIdLabelTapped(user: item)
        case likeCountLabel:
            print("좋아요 카운트 눌림")
            delegate?.likeCountLabelTapped(item: item)
        case commentCountLabel:
            delegate?.commentCountLabelTapped(user: item)
        case profileImageView:
            print("프로필 이미지 눌림")
        case moreImageView:
            delegate?.moreImageTapped(item: item)
        default:
            delegate?.commentCountLabelTapped(user: item)
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.likeButtonTapped(data: feedsItem!)
    }
    
    @IBAction func messageButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
}

extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let item = feedsItem {
            return item.postImgRes?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedMediaCell", for: indexPath) as? FeedMediaCell else { return UICollectionViewCell() }
        if let safeItems = feedsItem {
            cell.imageName = safeItems.postImgRes?[indexPath.row].postImgUrl
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
