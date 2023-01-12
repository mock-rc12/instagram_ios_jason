//
//  SearchCell.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "검색"
        bar.searchBarStyle = .minimal
        return bar
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        self.contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
