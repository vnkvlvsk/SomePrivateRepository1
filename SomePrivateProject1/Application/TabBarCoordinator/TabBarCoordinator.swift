import UIKit

enum TabBarCoordinatorEvents {
}

final class TabBarCoordinator: BaseCoordinator {
    
    var onEvent: ((TabBarCoordinatorEvents) -> Void)?
    
    // MARK: - Private properties

    private let router: TabBarRouter
    private let coordinatorsFactory: TabBarCoordinatorsFactory = .init()
    
    // MARK: - Lifecycle
    
    init(router: TabBarRouter) {
        self.router = router
        super.init()
    }
    
    override func start(deepLinkOption: DeepLinkOption?) {
        var tabBarControllers = [TabBarItem]()

        let reviewItem = makeReviewItem(deepLinkOption: deepLinkOption)
        tabBarControllers.append(reviewItem)
        
        let bucketItem = makeBucketItem(deepLinkOption: deepLinkOption)
        tabBarControllers.append(bucketItem)

        router.set(tabBarControllers)
    }
    
    // MARK: - Private methods
    
    @discardableResult
    private func makeReviewItem(deepLinkOption: DeepLinkOption? = nil) -> TabBarItem {
        let rootController = UINavigationController()

        let (coordinator, router) = coordinatorsFactory.makeReviewCoordinatorBox(rootController: rootController)
        addDependency(coordinator)
        coordinator.start(deepLinkOption: deepLinkOption)

        #warning("change image")
        let tabBarItem = TabBarItem(presentable: router, tabBarItemTitle: "Review", image: UIImage(systemName: "doc.text.magnifyingglass")!, tag: 3)

        return tabBarItem
    }
    
    @discardableResult
    private func makeBucketItem(deepLinkOption: DeepLinkOption? = nil) -> TabBarItem {
        let rootController = UINavigationController()

        let (coordinator, router) = coordinatorsFactory.makeBucketCoordinatorBox(rootController: rootController)
        addDependency(coordinator)
        coordinator.start(deepLinkOption: deepLinkOption)

        #warning("change image")
        let tabBarItem = TabBarItem(presentable: router, tabBarItemTitle: "Bucket", image: UIImage(systemName: "cart")!, tag: 4)
        
        return tabBarItem
    }
}
