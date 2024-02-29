import Foundation
import UIKit

enum AccountSettingsCoordinatorEvents {
}

final class AccountSettingsCoordinator: BaseCoordinator {
    
    // MARK: - Closure
    
    var onEvent: ((AccountSettingsCoordinatorEvents) -> Void)?
    
    // MARK: - Private properties
    
    private let router: Router
    private let controllersFactory: AccountSettingsCoordinatorFactory = .init()
    
    private var accountSettingsViewController: AccountSettingsViewController?
    
    // MARK: - Lifecycle
    
    init(router: Router) {
        self.router = router
    }
    
    override func start(deepLinkOption: DeepLinkOption?) {
        showAccountSettingsViewController()
    }
    
    override func trigger(with deepLinkOption: DeepLinkOption) {}
    
    // MARK: - Rout methods
    
    private func showAccountSettingsViewController() {
        accountSettingsViewController = controllersFactory.makeAccountSettingsViewController()
        
        router.setRootController(accountSettingsViewController)
    }
}
