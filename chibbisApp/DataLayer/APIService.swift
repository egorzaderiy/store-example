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

extension Formatter {
    static let iso8601withFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self) + "Z"
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}

class APIService {
    
    // since api uses similiar model we can afford this:
    private class func getData<T: Codable & EndpointRepresent>(callback: @escaping (_ model: Array<T>, _ error: Error?) -> () ) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601 // sadly api uses non-standard date format
        
        AF.request("https://front-task.chibbistest.ru/api/v1/\(T.endpointName)")
            .validate()
            .responseDecodable(of: [T].self, decoder: decoder) { (response) in
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
