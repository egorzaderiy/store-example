//
//  Router.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 15.10.2021.
//

import Foundation

class Router {

    static weak var mainPresenter: PresenterProtocol!
    
    private static let storeVC: StoreViewController = {
        return StoreViewController(nibName: "StoreViewController", bundle: nil)
    }()
    private static let hitsVC: HitsViewController = {
        return HitsViewController()
    }()
    private static let reviewsVC: ReviewsViewController = {
        return ReviewsViewController(nibName: "ReviewsViewController", bundle: nil)
    }()
    
    // MARK: - Init
    
    static var shared: Router = {
        let instance = Router()
        return instance
    }()
    
    private init() {}

    // MARK: - Nav
    
    static func showStore() {
        mainPresenter.showViewController(vc: storeVC)
    }
    
    static func showHits() {
        mainPresenter.showViewController(vc: hitsVC)
    }
    
    static func showReviews() {
        mainPresenter.showViewController(vc: reviewsVC)
    }
}
