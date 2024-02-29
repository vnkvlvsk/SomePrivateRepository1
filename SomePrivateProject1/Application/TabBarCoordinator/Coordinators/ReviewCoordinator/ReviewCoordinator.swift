import Foundation
import UIKit

enum ReviewCoordinatorEvents {
}

final class ReviewCoordinator: BaseCoordinator {
    
    // MARK: - Closure
    
    var onEvent: ((ReviewCoordinatorEvents) -> Void)?
    
    // MARK: - Private properties
    
    private let router: Router
    private let controllersFactory: ReviewCoordinatorsFactory = .init()
    
    private var categoriesListViewController: CategoriesListViewController?
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    override func start(deepLinkOption: DeepLinkOption?) {
        showCategoriesListViewController()
    }
    
    override func trigger(with deepLinkOption: DeepLinkOption) {}
    
    // MARK: - Rout methods
    
    private func showCategoriesListViewController() {
        categoriesListViewController = controllersFactory.makeCategoriesListViewController()
        
        categoriesListViewController?.onCategoryPressed = { [weak self] category in
            guard let self else { return }
            print("onCategoryPressed")
        }
        
        router.setRootController(categoriesListViewController)
    }
}
