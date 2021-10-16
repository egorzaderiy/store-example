//
//  TabbarViewController.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 15.10.2021.
//

import UIKit

class TabbarViewController: UIViewController, UITabBarDelegate, PresenterProtocol {
    
    @IBOutlet weak var tabBar: UITabBar!

    @IBOutlet weak var storeItem: UITabBarItem!
    @IBOutlet weak var hitsItem: UITabBarItem!
    @IBOutlet weak var reviewsItem: UITabBarItem!
    
    weak var currentVC: UIViewController?
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Nav
    
    func showViewController(vc: UIViewController) {
        if let childVC = currentVC {  // Child VC removal
            childVC.willMove(toParent: nil)
            childVC.removeFromParent()
            childVC.view.removeFromSuperview()
        }
        
        addChild(vc)
        view.addSubview(vc.view)
        view.bringSubviewToFront(tabBar)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
      
        vc.didMove(toParent: self)
    }
    
    // MARK: - Tabbar Delegate
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) { // responding to Tabbar actions
        switch item { // tell router what we want to show
        case storeItem:
            Router.showStore()
        case hitsItem:
            Router.showHits()
        case reviewsItem:
            Router.showReviews()
        default:
            break
        }
    }
}

