import Foundation

final class BucketCoordinatorsFactory {
    
    func makeBucketListViewController() -> BucketListViewController {
        let viewModel = BucketListViewModel()
        return BucketListViewController(viewModel: viewModel)
    }
    
    func makeOrdersListViewController() -> OrdersListViewController {
        let viewModel = OrdersListViewModel()
        return OrdersListViewController(viewModel: viewModel)
    }
}
