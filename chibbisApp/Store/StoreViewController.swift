//
//  StoreViewController.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let dataSource = StoreDataSource()

    lazy var viewModel : StoreViewModel = {
        return StoreViewModel(dataSource: dataSource)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StoreCell", bundle: nil), forCellReuseIdentifier: "StoreCell")
        
        self.tableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.getStores()
        
        tableView.setContentOffset(CGPoint(x: 0, y: searchBar.bounds.height), animated: false)
    }

}

extension StoreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.filterString = nil
        } else {
            viewModel.filterString = searchText
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

