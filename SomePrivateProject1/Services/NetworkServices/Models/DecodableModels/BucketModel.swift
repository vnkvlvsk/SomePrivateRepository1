import Foundation

struct BucketModel: Decodable {
    let restaurantImageURL: URL
    let restaurantName: String
    var positionNumber: Int
    var price: Double
    var deliveryAddress: String
    var workingHours: DateInterval
}

extension BucketModel {
    var isOpened: Bool {
        workingHours.contains(Date()) ? true : false
    }
}
