import Foundation

final class BucketListViewModel {
    
    // MARK: - Public properties
    
    var dataSource: [BucketModel] = []
    
    // MARK: - Public methods
    
    func setupDataSource() async throws {
        dataSource = try await NetworkService.shared.getAllBuckets()
    }
}
