//
//  ReviewsViewModel.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 17.10.2021.
//

import UIKit

class ReviewsViewModel {
    
    weak var dataSource : GenericDataSource<ReviewModelElement>?

    init(dataSource : GenericDataSource<ReviewModelElement>?) {
        self.dataSource = dataSource
    }
    
    func getReviews() {
        APIService.getReviews { model, error in
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


class ReviewDataSource: GenericDataSource<ReviewModelElement>, UITableViewDataSource {
    
    static let dateFormatter: DateFormatter = { // optimize to not create too much formatters
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.val.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell

        let reviewModel = data.val[indexPath.row]
        
        cell.dateLabel.text = ReviewDataSource.dateFormatter.string(from: reviewModel.dateAdded)
        cell.headerLabel.text = reviewModel.userFIO + " о ресторане " + reviewModel.restaurantName
        cell.reviewTextLabel.text = reviewModel.message
        
        cell.iconImageView.image = reviewModel.isPositive ? UIImage(named: "thumbs-up-solid") : UIImage(named: "thumbs-down-solid")
        
        return cell
    }
}
