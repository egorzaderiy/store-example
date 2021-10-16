// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeModel = try? newJSONDecoder().decode(StoreModel.self, from: jsonData)

import Foundation

// MARK: - StoreModelElement
struct StoreModelElement: Codable, EndpointRepresent {
    let name: String
    let logo: String
    let minCost, deliveryCost, deliveryTime, positiveReviews: Int
    let reviewsCount: Int
    let specializations: [Specialization]

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case logo = "Logo"
        case minCost = "MinCost"
        case deliveryCost = "DeliveryCost"
        case deliveryTime = "DeliveryTime"
        case positiveReviews = "PositiveReviews"
        case reviewsCount = "ReviewsCount"
        case specializations = "Specializations"
    }
    
    static var endpointName: String { "restaurants" }
}

// MARK: - Specialization
struct Specialization: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}

typealias StoreModel = [StoreModelElement]
