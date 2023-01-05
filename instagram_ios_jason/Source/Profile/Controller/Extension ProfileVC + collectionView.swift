//
//  Extension ProfileVC + collectionView.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            guard let item = profileItem else { return 0 }
            return item.profilePostImgs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileInfoCell", for: indexPath) as? ProfileInfoCell else { fatalError("Cannot create new cell") }
            cell.item = profileItem
            cell.profileType = self.profileType
            cell.delegate = self
            cell.configure()
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentsCell", for: indexPath) as? ContentsCell else { fatalError("ContentsCell") }
            guard let item = profileItem else { return UICollectionViewCell() }
            cell.item = item.profilePostImgs[indexPath.row]
            cell.configure()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileTabHeaderView", for: indexPath) as? ProfileTabHeaderView else { return UICollectionReusableView() }
            header.configure()
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension ProfileViewController: ProfileVCDelegate {
    func profileEditSuccess() {
        setupData()
    }
    
    func followButtonTapped() {
        print(#function)
    }
    
    func messageButtonTapped() {
        print(#function)
    }
    
    func editProfileButtonTapped() {
        print(#function)
        dump(self.profileItem)
        guard let vc = UIStoryboard(name: "EditMyProfile", bundle: nil).instantiateViewController(withIdentifier: "EditMyProfileViewController") as? EditMyProfileViewController else { return }
        let naviController = UINavigationController(rootViewController: vc)
        vc.myProfile = self.profileItem
        vc.delegate = self
        naviController.modalPresentationStyle = .fullScreen
        present(naviController, animated: true)
    }
}
