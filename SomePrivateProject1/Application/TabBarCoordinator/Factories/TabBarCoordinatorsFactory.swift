import Foundation
import UIKit

final class TabBarCoordinatorsFactory {
    
    func makeReviewCoordinatorBox(rootController: UINavigationController) -> (ReviewCoordinator, Presentable) {
        let router = Router(rootController: rootController)
        let coordinator = ReviewCoordinator(router: router)
        return (coordinator, router)
    }
    
    func makeBucketCoordinatorBox(rootController: UINavigationController) -> (BucketCoordinator, Presentable) {
        let router = Router(rootController: rootController)
        let coordinator = BucketCoordinator(router: router)
        return (coordinator, router)
    }
    
    func makeAccountSettingsCoordinatorBox(rootController: UINavigationController) -> (AccountSettingsCoordinator, Presentable) {
        let router = Router(rootController: rootController)
        let coordinator = AccountSettingsCoordinator(router: router)
        return (coordinator, router)
    }
}
