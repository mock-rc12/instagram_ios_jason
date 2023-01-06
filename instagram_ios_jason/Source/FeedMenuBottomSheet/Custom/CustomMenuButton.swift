//
//  CustomMenuButton.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/06.
//

import UIKit

class CustomMenuButton: AlignableButton {
    
    init(image: UIImage?, title: String) {
        super.init(frame: CGRect.zero)
        self.imageView?.contentMode = .center

        self.setPreferredSymbolConfiguration(.init(pointSize: 23), forImageIn: .normal)
        self.setImage(image, for: .normal)
        self.setTitle(title, for: .normal)
        self.iconAlignment = .top
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {

        self.titleLabel?.textColor = .white
        self.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        self.backgroundColor = #colorLiteral(red: 0.2069494128, green: 0.21192801, blue: 0.2118408382, alpha: 1)
        self.tintColor = .label
        self.titleLabel?.textAlignment = .center
//        self.centerVerticallyWithPadding(padding: 15)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}



extension UIButton {
    func centerVerticallyWithPadding(padding : CGFloat) {
            guard
                let imageViewSize = self.imageView?.frame.size,
                let titleLabelSize = self.titleLabel?.frame.size else {
                return
            }

            let totalHeight = imageViewSize.height + titleLabelSize.height + padding

            self.imageEdgeInsets = UIEdgeInsets(
                top: max(0, -(totalHeight - imageViewSize.height)),
                left: 0.0,
                bottom: 0.0,
                right: -titleLabelSize.width
            )

            self.titleEdgeInsets = UIEdgeInsets(
                top: (totalHeight - imageViewSize.height),
                left: -imageViewSize.width,
                bottom: -(totalHeight - titleLabelSize.height),
                right: 0.0
            )

            self.contentEdgeInsets = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: titleLabelSize.height,
                right: 0.0
            )
        }
    
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
              let text = self.titleLabel?.text,
              let font = self.titleLabel?.font
        else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
    func alignTextUnderImage(spacing: CGFloat = 6.0) {
        guard let image = imageView?.image, let label = titleLabel,
          let string = label.text else { return }

          titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0.0)
        let titleSize = string.size(withAttributes: [NSAttributedString.Key.font: label.font as Any])
          imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
      }

}
