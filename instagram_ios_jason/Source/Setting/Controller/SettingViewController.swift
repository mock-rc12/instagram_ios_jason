//
//  SettingViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/12.
//

import UIKit

class SettingViewController: UIViewController {
    
    var data: [SettingModel] = []
    
    var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        self.data = SettingDataManager().getSettingData()
        self.navigationItem.title = "설정"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .label
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func setupTableView() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        tableView.register(AccountCenterCell.self, forCellReuseIdentifier: "AccountCenterCell")
        tableView.register(AccountInfoCell.self, forCellReuseIdentifier: "AccountInfoCell")
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return data.count
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell() }
            cell.configure()
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell else { return UITableViewCell() }
            cell.data = data[indexPath.row]
            cell.setupUI()
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCenterCell", for: indexPath) as? AccountCenterCell else { return UITableViewCell() }
            cell.configure()
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfoCell", for: indexPath) as? AccountInfoCell else { return UITableViewCell() }
            cell.setupUI()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 45
        case 2:
            return 150
        default:
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let selectedType = data[indexPath.row].settingType
            switch selectedType {
            case .account:
                let vc = AccountSettingViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                ToastNoti.showToast("준비중입니다.", withDuration: 1.5, delay: 1, vc: self)
            }
            
        default:
            ToastNoti.showToast("준비중입니다.", withDuration: 1.5, delay: 1, vc: self)
        }
    }
}

extension SettingViewController: SettingCustomDelegate {
    func addAccountTapped() {
        ToastNoti.showToast("준비중입니다.", withDuration: 1.5, delay: 1, vc: self)
    }
    
    func logoutTapped() {
        ToastNoti.showToast("준비중입니다.", withDuration: 1.5, delay: 1, vc: self)
    }
}
