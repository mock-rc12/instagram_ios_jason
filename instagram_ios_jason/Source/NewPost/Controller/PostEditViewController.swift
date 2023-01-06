//
//  PostEditViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit
import Kingfisher

class PostEditViewController: UIViewController {
    
    enum EditViewType {
        case newPost
        case modify
    }
    
    var editType: EditViewType = .newPost
    
    var post: FeedsResult?
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var delegate: HomeVCDelegate?
    var selectedImage: [UIImage]?
    
    @IBOutlet weak var facebookShareToggle: UISwitch!
    @IBOutlet weak var tumblrShareToggle: UISwitch!
    @IBOutlet weak var twitterShareToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        switch editType {
        case .newPost:
            self.navigationItem.title = "새 게시글"
        case .modify:
            self.navigationItem.title = "게시글 수정"
            if let data = post {
                textView.text = data.content
                if data.postImgRes?.count != 0 {
                    let url = URL(string: data.postImgRes?[0].postImgUrl ?? "")
                    selectedImageView.kf.setImage(with: url)
                }
            }
        }
        
        _ = [facebookShareToggle, tumblrShareToggle, twitterShareToggle].map({
            $0?.setOn(false, animated: false)
        })
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
        self.navigationItem.rightBarButtonItem = doneButton

        if selectedImage?.count != 0 && selectedImage != nil {
            selectedImageView.image = selectedImage![0]
        }
    }
    
    func uploadImage(completion: @escaping ([PostImg]) -> Void) {
        var postImg: [PostImg] = []
        selectedImage?.forEach({ image in
            FirebaseManager.uploadImage(image: image) { [weak self] url in
                if let imgUrl = url {
                    postImg.append(PostImg(postImgUrl: "\(imgUrl)"))
                    if self?.selectedImage?.count == postImg.count {
                        completion(postImg)
                    }
                }
            }
        })
    }
    
    @objc private func doneButtonTapped() {
        
        // 텍스트가 비어있지 않다면
        if self.textView.text != nil && self.textView.text != "" {
            
            IndicatorView.shared.showIndicator()
            IndicatorView.shared.show()
            
            if editType == .newPost {
                // firebase 이미지 업로드 후 url 리턴, 비동기처리
                uploadImage { [weak self] imgArray in
                    
                    let param = NewPostModel(content: (self?.textView.text)!, postImgReqs: imgArray)

                    let dataManager = NewPostDataManager()
                    dataManager.newPostNetworkData(idx: Secret.userIdx, param: param) { [weak self] isSucessed in
                        if isSucessed == true {
                            IndicatorView.shared.dismiss()
                            self?.delegate?.feedUploadSuccessed()
                            self?.navigationController?.dismiss(animated: true)
                        } else {
                            print("업로드 실패~")
                        }
                    }
                }
            // 게시글 수정일 경우
            } else {
                if let data = post {
                    let manager = FeedMenuDataManager()
                    let body = ContentBody(content: textView.text)
                    manager.feedEditNetworkData(method: .patch, body: body, userIdx: data.userIdx, postIdx: data.postIdx) { [weak self] isSuccess in
                        if isSuccess == true {
                            print("수정 성공")
                            IndicatorView.shared.dismiss()
                            self?.navigationController?.popViewController(animated: true)
                            self?.delegate?.feedModifySuccessed()
                        }
                    }
                }
            }

        } else {
            ToastNoti.showToast("내용을 입력해주세요", withDuration: 1, delay: 1.5, vc: self)
        }
    }
}
