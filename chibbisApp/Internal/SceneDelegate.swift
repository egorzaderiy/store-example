//
//  SceneDelegate.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 15.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
  
        let vc = TabbarViewController(nibName: "TabbarViewController", bundle: nil)
        Router.mainPresenter = vc
        window.rootViewController = vc
        
        Router.showStore()
        
        self.window = window
        window.makeKeyAndVisible()
    }



}

