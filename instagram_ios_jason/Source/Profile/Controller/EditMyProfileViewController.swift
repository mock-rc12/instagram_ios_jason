//
//  EditMyProfileViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/05.
//

import UIKit

enum EditType {
    case profileImage
    case name
    case id
    case introduction
    case website
    case transitionToProfessional
    case privateSetting
}

class EditMyProfileViewController: UIViewController {
    
    var myProfile: ProfileResult!
    var delegate: ProfileVCDelegate?
    let dataManager = ProfileDataManager()
    
    @IBOutlet weak var editTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupTableView() {
        editTableView.register(EditProfileInfoCell.self, forCellReuseIdentifier: "EditProfileInfoCell")
        editTableView.delegate = self
        editTableView.dataSource = self
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "프로필 수정"
        
    }
    
    func makeCell(type: EditType, tableView: UITableView, index: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileInfoCell", for: index) as? EditProfileInfoCell else { return UITableViewCell() }
        cell.editType = type
        cell.initData = self.myProfile
        cell.setupUI()
        return cell
    }
    
    private func popDetailVC(type: EditType) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditDetailViewController") as? EditDetailViewController else { return }
        vc.editType = type
        vc.delegate = self
        vc.userData = myProfile
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nvCancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func nvDoneButtonTapped(_ sender: UIBarButtonItem) {
        IndicatorView.shared.show()
        let param = EditProfileModle(userIdx: myProfile.userIdx, userId: myProfile.userId, name: myProfile.name, profileImg: myProfile.profileImg, website: myProfile.website, introduction: myProfile.introduction)
        dataManager.editProfileNetworkData(param: param, idx: Secret.userIdx) { [weak self] isSuccess in
            if isSuccess == true {
                IndicatorView.shared.dismiss()
                self?.dismiss(animated: true, completion: {
                    self?.delegate?.profileEditSuccess()
                })
            } else {
                
            }
        }
    }
}

extension EditMyProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return UITableViewCell()
        case 1:
            let cell = makeCell(type: .name, tableView: tableView, index: indexPath)
            return cell
        case 2:
            let cell = makeCell(type: .id, tableView: tableView, index: indexPath)
            return cell
        case 3:
            let cell = makeCell(type: .introduction, tableView: tableView, index: indexPath)
            return cell
        case 4:
            let cell = makeCell(type: .website, tableView: tableView, index: indexPath)
            return cell
        case 5:
            let cell = makeCell(type: .transitionToProfessional, tableView: tableView, index: indexPath)
            return cell
        case 6:
            let cell = makeCell(type: .privateSetting, tableView: tableView, index: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("")
        case 1:
            popDetailVC(type: .name)
        case 2:
            popDetailVC(type: .id)
        case 3:
            popDetailVC(type: .introduction)
        case 4:
            popDetailVC(type: .website)
        case 5:
            print("")
        case 6:
            print("")
        default:
            print("")
        }
    }
}

extension EditMyProfileViewController: EditProfileDelegate {
    func backButtonTapped(value: String, type: EditType) {
        print("value: \(value)")
        switch type {
        case .profileImage:
            print("추후 구현 예정")
        case .name:
            self.myProfile.name = value
        case .id:
            self.myProfile.userId = value
        case .introduction:
            self.myProfile.introduction = value
        case .website:
            self.myProfile.website = value
        default:
            print("기능 미배정")
        }
        setupTableView()
        editTableView.reloadData()
    }
}
