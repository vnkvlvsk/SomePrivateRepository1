import Foundation
import UIKit

final class AppCoordinatorFactory {
    func makeTabBarCoordinatorBox(router: TabBarRouter) -> TabBarCoordinator {
        return TabBarCoordinator(router: router)
    }
}
