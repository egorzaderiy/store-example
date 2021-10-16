//
//  Router.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 15.10.2021.
//

import Foundation

class Router {

    static var shared: Router = {
        let instance = Router()
        return instance
    }()

    private init() {}

}
