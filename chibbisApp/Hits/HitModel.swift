// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hitModel = try? newJSONDecoder().decode(HitModel.self, from: jsonData)

import Foundation

// MARK: - HitModelElement
struct HitModelElement: Codable, EndpointRepresent {
    let productName: String
    let productImage: String
    let productPrice: Int
    let productDescription: String
    let restaurantID: Int
    let restaurantName: String
    let restaurantLogo: String

    enum CodingKeys: String, CodingKey {
        case productName = "ProductName"
        case productImage = "ProductImage"
        case productPrice = "ProductPrice"
        case productDescription = "ProductDescription"
        case restaurantID = "RestaurantId"
        case restaurantName = "RestaurantName"
        case restaurantLogo = "RestaurantLogo"
    }
    
    static var endpointName: String { "hits" }
}

typealias HitModel = [HitModelElement]
