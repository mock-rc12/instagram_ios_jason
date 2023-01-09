//
//  SearchViewController.swift
//  instagram_ios_jason
//
//  Created by 김지수 on 2023/01/10.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = SearchDataManager()
    
    private var searchResult: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func viewProfileVC(data: SearchResult) {
        guard let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        vc.userIdx = data.userIdx
        vc.userId = data.name
        if data.userIdx == Secret.userIdx {
            vc.profileType = .myProfile
        } else {
            vc.profileType = .otherUserProfile
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell else { return UITableViewCell() }
        cell.searchItem = searchResult[indexPath.row]
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = searchResult[indexPath.row]
        viewProfileVC(data: data)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            self.searchResult = []
            self.tableView.reloadData()
        } else {
            dataManager.getSearchNetworkData(userIdx: Secret.userIdx, word: searchText) { [weak self] result in
                self?.searchResult = result
                self?.tableView.reloadData()
            }
        }
    }
}
