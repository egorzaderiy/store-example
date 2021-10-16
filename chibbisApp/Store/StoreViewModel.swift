//
//  StoreViewModel.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import Foundation
import UIKit
import Nuke

class StoreViewModel {
    
    weak var dataSource : GenericDataSource<StoreModelElement>?

    var originalModel: [StoreModelElement] = []
    var filterString: String? {
        didSet {
            if let filterString = filterString?.lowercased() {
                dataSource?.data.val = originalModel.filter { $0.name.lowercased().contains(filterString) }
            } else {
                dataSource?.data.val = originalModel
            }
         }
    }
    
    init(dataSource : GenericDataSource<StoreModelElement>?) {
        self.dataSource = dataSource
    }
    
    func getStores() {
        APIService.getStores { model, error in
            DispatchQueue.main.async { [weak self] in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    self?.dataSource?.data.val = model
                    self?.originalModel = model
                }
            }
        }
    }
}


class StoreDataSource: GenericDataSource<StoreModelElement>, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.val.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCell

        cell.nameLabel.text = data.val[indexPath.row].name
        cell.reviewLabel.text = "\(data.val[indexPath.row].positiveReviews)%"
        cell.descLabel.text = data.val[indexPath.row].specializations.map { $0.name }.joined(separator: " \\ ")
        
        if let str = data.val[indexPath.row].logo.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: " ").inverted),
           let url = URL(string: str) {
            Nuke.loadImage(with: url, into: cell.storeImage)
        }
        return cell
    }
}
