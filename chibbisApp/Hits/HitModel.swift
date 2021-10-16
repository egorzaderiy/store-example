// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hitModel = try? newJSONDecoder().decode(HitModel.self, from: jsonData)

import Foundation

// MARK: - HitModelElement
struct HitModelElement: Codable, EndpointRepresent {
    let isPositive: Bool
    let message, dateAdded, userFIO, restaurantName: String

    enum CodingKeys: String, CodingKey {
        case isPositive = "IsPositive"
        case message = "Message"
        case dateAdded = "DateAdded"
        case userFIO = "UserFIO"
        case restaurantName = "RestaurantName"
    }
    
    static var endpointName: String { "hits" }
}

typealias HitModel = [HitModelElement]
