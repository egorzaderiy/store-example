// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reviewModel = try? newJSONDecoder().decode(ReviewModel.self, from: jsonData)

import Foundation

// MARK: - ReviewModelElement
struct ReviewModelElement: Codable, EndpointRepresent {
    let isPositive: Bool
    let message, userFIO, restaurantName: String
    let dateAdded: Date
    
    enum CodingKeys: String, CodingKey {
        case isPositive = "IsPositive"
        case message = "Message"
        case dateAdded = "DateAdded"
        case userFIO = "UserFIO"
        case restaurantName = "RestaurantName"
    }
    
    static var endpointName: String { "reviews" }
}

typealias ReviewModel = [ReviewModelElement]
