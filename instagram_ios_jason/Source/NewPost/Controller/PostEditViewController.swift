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
    
    @objc private func doneButtonTapped() {
        let tempImg = "https://korean.visitseoul.net/comm/getImage?srvcId=MEDIA&parentSn=51629&fileTy=MEDIA&fileNo=1"
        
        if textView.text != nil && textView.text != "" {
            IndicatorView.shared.showIndicator()
            IndicatorView.shared.show()
            let img = PostImg(postImgUrl: tempImg)
            let param = NewPostModel(content: textView.text, postImgReqs: [img])
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
