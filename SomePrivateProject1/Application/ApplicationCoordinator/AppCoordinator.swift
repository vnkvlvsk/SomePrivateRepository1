import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {

    // MARK: - Private properties

    private let window: UIWindow
    private let coordinatorFactory: AppCoordinatorFactory

    // MARK: - Lifecycle

    init(window: UIWindow, coordinatorFactory: AppCoordinatorFactory) {
        self.window = window
        self.coordinatorFactory = coordinatorFactory
    }

    override func start(deepLinkOption: DeepLinkOption?) {
        let startController = self.getStartCoordinatorBaseController(deepLinkOption: deepLinkOption)
        self.window.rootViewController = startController
        self.window.makeKeyAndVisible()
    }

    // MARK: - Private methods

    private func getStartCoordinatorBaseController(
        deepLinkOption: DeepLinkOption? = nil
    ) -> UIViewController {
        return runUserTabBar(deepLinkOption: deepLinkOption)
    }

    private func runUserTabBar(deepLinkOption: DeepLinkOption? = nil) -> UIViewController {
        let rootController = UITabBarController()
        rootController.tabBar.tintColor = .black
        rootController.tabBar.unselectedItemTintColor = .gray
        rootController.tabBar.backgroundColor = .white
        let tabBarRouter = TabBarRouter(rootController: rootController)
        let coordinator = coordinatorFactory.makeTabBarCoordinatorBox(router: tabBarRouter)

        addDependency(coordinator)
        coordinator.start(deepLinkOption: deepLinkOption)

        return rootController
    }
}
