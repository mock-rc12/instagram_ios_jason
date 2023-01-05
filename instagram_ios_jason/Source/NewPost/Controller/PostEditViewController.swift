//
//  PostEditViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit

class PostEditViewController: UIViewController {
    
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
        self.navigationItem.title = "새 게시물"
        _ = [facebookShareToggle, tumblrShareToggle, twitterShareToggle].map({
            $0?.setOn(false, animated: false)
        })
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = #colorLiteral(red: 0, green: 0.3905753791, blue: 0.8777532578, alpha: 1)
        self.navigationItem.rightBarButtonItem = doneButton
        
        if selectedImage?.count != 0 {
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
            
            // firebase 이미지 업로드 후 url 리턴, 비동기처리
            uploadImage { [weak self] imgArray in
                
                let param = NewPostModel(content: (self?.textView.text)!, postImgReqs: imgArray)
                print("POST !! 🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                print(imgArray)
                
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
        }
    }
}
