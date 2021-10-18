//
//  HitsViewModel.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 17.10.2021.
//

import UIKit
import Nuke

class HitsViewModel {
    
    weak var dataSource : GenericDataSource<HitModelElement>?

    init(dataSource : GenericDataSource<HitModelElement>?) {
        self.dataSource = dataSource
    }
    
    func getReviews() {
        APIService.getHits { model, error in
            DispatchQueue.main.async { [weak self] in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    self?.dataSource?.data.val = model
                }
            }
        }
    }
}


class HitsDataSource: GenericDataSource<HitModelElement>, UITableViewDataSource {
    
    var showDetail: ((_ image: UIImage) -> Void)?
    var hideDetail: (() -> Void)?

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.val.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HitCell", for: indexPath) as! HitCell

        let hitModel = data.val[indexPath.row]
        
        if let str = hitModel.productImage.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: " ").inverted),
           let url = URL(string: str) {
            Nuke.loadImage(with: url, into: cell.mainImageView)
        }
        cell.nameLabel.text = hitModel.productName
        
        cell.showDetail = showDetail
        cell.hideDetail = hideDetail

        return cell
    }
}
