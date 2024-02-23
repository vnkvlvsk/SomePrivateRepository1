import Foundation
import UIKit

enum BucketCoordinatorEvents {
}

final class BucketCoordinator: BaseCoordinator {
    
    // MARK: - Closure
    
    var onEvent: ((BucketCoordinatorEvents) -> Void)?
    
    // MARK: - Private properties
    
    private let router: Router
    private let controllersFactory: BucketCoordinatorsFactory = .init()
    
    private var bucketListViewController: BucketListViewController?
    private var ordersListViewController: OrdersListViewController?
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    override func start(deepLinkOption: DeepLinkOption?) {
        showBucketListViewController()
    }
    
    override func trigger(with deepLinkOption: DeepLinkOption) {}
    
    // MARK: - Rout methods
    
    private func showBucketListViewController() {
        bucketListViewController = controllersFactory.makeBucketListViewController()
        
        bucketListViewController?.onOrderButtonPressed = { [weak self] in
            guard let self else { return }
            self.showOrdersListViewController()
        }
        
        router.setRootController(bucketListViewController)
    }
    
    private func showOrdersListViewController() {
        ordersListViewController = controllersFactory.makeOrdersListViewController()
        
        router.push(ordersListViewController, hideBottomBar: false)
    }
}
