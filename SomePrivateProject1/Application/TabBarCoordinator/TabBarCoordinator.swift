import Foundation

class TabBarCoordinator: BaseCoordinator {
    
    // MARK: - Private properties

    private let router: TabBarRouter
    
    // MARK: - Lifecycle
    
    init(router: TabBarRouter) {
        self.router = router
        super.init()
    }
}
