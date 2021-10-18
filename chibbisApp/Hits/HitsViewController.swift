//
//  HitsViewController.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import UIKit

class HitsViewController: UIViewController {
    weak var tableView: UITableView!
    weak var imageView: UIImageView!
    
    let dataSource = HitsDataSource()
    
    lazy var viewModel : HitsViewModel = {
        return HitsViewModel(dataSource: dataSource)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let table = UITableView()
        tableView = table
        view.addSubview(table)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(HitCell.self, forCellReuseIdentifier: "HitCell")
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        
        let imageView = UIImageView()
        imageView.isHidden = true
        self.imageView = imageView
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        imageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 40).isActive = true
        imageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -40).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        imageView.backgroundColor = UIColor.white
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1.0
        
        dataSource.showDetail = { [weak self] image in
            self?.imageView.image = image
            imageView.isHidden = false
        }
        dataSource.hideDetail = {
            imageView.isHidden = true
        }
        
        self.tableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.getReviews()

    }



}
