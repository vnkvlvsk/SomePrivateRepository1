import Foundation

final class NetworkService {
    static let shared: NetworkService = NetworkService.init()
    
    private init() {}
    
    // MARK: - Food Category
    
    func getAllFoodCategories() async throws -> [FoodCategoryModel] {
        ///
//        guard let url = URL(string: "someURL") else {
//            throw NetworkServiceError.badURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkServiceError.badID }
//        let models: [FoodCategoryModel] = try JSONDecoder().decode([FoodCategoryModel].self, from: data)
//        return models
        ///
        
        // Just for test
        guard let imageURL = URL(string: "someImageURL") else {
            throw NetworkServiceError.badURL
        }
        
        var foodCategories: [FoodCategoryModel] = []
        
        for _ in 0..<8 {
            foodCategories = foodCategories + [FoodCategoryModel(title: "Kebab", imageURL: imageURL),
                                               FoodCategoryModel(title: "Pizza", imageURL: imageURL),
                                               FoodCategoryModel(title: "Sushi", imageURL: imageURL),
                                               FoodCategoryModel(title: "Ramen", imageURL: imageURL),
                                               FoodCategoryModel(title: "Polish", imageURL: imageURL)]
        }
        
        return foodCategories
        //
    }
    
    func getPopularFoodCategories() async throws -> [FoodCategoryModel] {
        ///
//        guard let url = URL(string: "someURL") else {
//            throw NetworkServiceError.badURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkServiceError.badID }
//        let models: [FoodCategoryModel] = try JSONDecoder().decode([FoodCategoryModel].self, from: data)
//        return models
        ///
        
        // Just for test
        guard let imageURL = URL(string: "someImageURL") else {
            throw NetworkServiceError.badURL
        }
        
        return [
            FoodCategoryModel(title: "Kebab", imageURL: imageURL),
            FoodCategoryModel(title: "Pizza", imageURL: imageURL),
            FoodCategoryModel(title: "Sushi", imageURL: imageURL),
            FoodCategoryModel(title: "Ramen", imageURL: imageURL),
            FoodCategoryModel(title: "Polish", imageURL: imageURL)
        ]
        //
    }
    
    // MARK: - Bucket
    
    func getAllBuckets() async throws -> [BucketModel] {
        ///
//        guard let url = URL(string: "someURL") else {
//            throw NetworkServiceError.badURL
//        }
//
//        let (data, response) = try await URLSession.shared.data(from: url)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkServiceError.badID }
//        let models: [BucketModel] = try JSONDecoder().decode([BucketModel].self, from: data)
//        return models
        ///
        // Just for test
        guard let imageURL = URL(string: "someImageURL") else {
            throw NetworkServiceError.badURL
        }
        
        return [
            BucketModel(restaurantImageURL: imageURL, restaurantName: "Restaurant 1", positionNumber: 1, price: 44.2, deliveryAddress: "Some address 1", workingHours: DateInterval(start: Date(), end: Date())),
            BucketModel(restaurantImageURL: imageURL, restaurantName: "Restaurant 2", positionNumber: 3, price: 100.31, deliveryAddress: "Some address 2", workingHours: DateInterval(start: Date(), end: Date()))
        ]
        //
    }
}

extension NetworkService {
    enum NetworkServiceError: Error {
        case badURL
        case badID
    }
}
