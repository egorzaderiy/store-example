//
//  APIService.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import Foundation
import Alamofire

protocol EndpointRepresent {
    static var endpointName: String { get }
}

class APIService {
    
    // since api uses similiar model we can afford this:
    private class func getData<T: Codable & EndpointRepresent>(callback: @escaping (_ model: Array<T>, _ error: Error?) -> () ) {
        AF.request("https://front-task.chibbistest.ru/api/v1/\(T.endpointName)")
            .validate()
            .responseDecodable(of: [T].self) { (response) in
                guard let model = response.value else {
                    callback([], response.error?.underlyingError)
                    return
                }
                callback(model, nil)
            }
    }
    
    class func getStores(callback: @escaping (_ model: StoreModel, _ error: Error?) -> () ) {
        getData(callback: callback)
    }
    
    class func getReviews(callback: @escaping (_ model: ReviewModel, _ error: Error?) -> () ) {
        getData(callback: callback)
    }
    
    class func getHits(callback: @escaping (_ model: HitModel, _ error: Error?) -> () ) {
        getData(callback: callback)
    }
}
