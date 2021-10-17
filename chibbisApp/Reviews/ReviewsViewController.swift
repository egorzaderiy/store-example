//
//  ReviewsViewController.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import UIKit

class ReviewsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = ReviewDataSource()
    
    lazy var viewModel : ReviewsViewModel = {
        return ReviewsViewModel(dataSource: dataSource)
    }()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        
        self.tableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        
        self.viewModel.getReviews()
    }

    @objc func refreshAction() {
        viewModel.getReviews()
    }


}
