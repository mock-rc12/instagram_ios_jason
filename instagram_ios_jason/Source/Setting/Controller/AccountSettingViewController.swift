//
//  AccountSettingViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit
import SnapKit

class AccountSettingViewController: BaseViewController {
    
    var settingModel = ["개인정보", "저장됨", "친한 친구", "계정 상태", "아바타", "언어", "캡션", "관심사 관리", "민감한 내용이 포함된 콘텐츠 관리하기", "연락처 동기화", "다른 앱과 공유", "데이터 사용", "원본 사진", "인증 요청", "활동 검토", "브랜디드 콘텐츠", "계정 삭제", "프로페셔널 계정으로 전환", "새로운 프로페셔널 계정으로 추가"]
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(AccountSettingCell.self, forCellReuseIdentifier: "AccountSettingCell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        navigationItem.backBarButtonItem?.tintColor = .label
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = "계정"
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
    }
}

extension AccountSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSettingCell", for: indexPath) as? AccountSettingCell else { return UITableViewCell() }
        cell.settingTitle = settingModel[indexPath.row]
        cell.configure()
        // 맨 아래 두개 셀
        if indexPath.row >= settingModel.count - 2 {
            cell.setupSpecial()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let vc = UIStoryboard(name: "PersonalInfo", bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoViewController") as? PersonalInfoViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
