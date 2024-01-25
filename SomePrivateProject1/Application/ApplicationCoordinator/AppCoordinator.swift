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
        let appStartController = makeAppStartViewController()

        appStartController.didFetchConfig = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if UserManager.shared.isOnboardingComplete, let pincodeController = self.getPinCodeController() {
                    pincodeController.didConfirmPincode = { [weak self] pincode in
                        guard let self = self else { return }
                        let startController = self.getStartCoordinatorBaseController(deepLinkOption: deepLinkOption)
                        self.window.rootViewController = startController
                        self.window.makeKeyAndVisible()
                        if let currentProcessingDeepLink = DynamicLinksHandler.shared.currentHandlingOption, let tabBarCoordinator = self.childCoordinators.first(where: { $0 is TabBarCoordinator }) as? TabBarCoordinator {
                            tabBarCoordinator.handle(deeplink: currentProcessingDeepLink)
                        } else if let userInfo = AppDelegate.shared.pushNotificationsManager.handlingNotification {
                            AppDelegate.shared.pushNotificationsManager.handle(notification: userInfo)
                        }
                    }
                    pincodeController.onLogoutAction = {
                        ProgressHUD.show()
                        UserManager.shared.resetAllData { result in
                            DispatchQueue.main.async {
                                ProgressHUD.hide()
                                switch result {
                                case .success:
                                    self.swapRootController()
                                case let .failure(error):
                                    EventManager.showExceptionMessage(for: error, onOkButtonAction: nil)
                                }
                            }
                        }
                    }
                    self.window.rootViewController = pincodeController
                    self.window.makeKeyAndVisible()
                } else {
                    let startController = self.getStartCoordinatorBaseController(deepLinkOption: deepLinkOption)
                    self.window.rootViewController = startController
                    self.window.makeKeyAndVisible()
                }
            }
        }

        self.window.rootViewController = appStartController
        self.window.makeKeyAndVisible()
    }

    // MARK: - Private methods

    private func getStartCoordinatorBaseController(
        deepLinkOption: DeepLinkOption? = nil
    ) -> UIViewController {
        return runUserTabBar(deepLinkOption: deepLinkOption)
    }

    private func runUserTabBar(deepLinkOption: DeepLinkOption? = nil) -> UIViewController {
        let rootController = ESTabBarController()
        let tabBarRouter = TabBarRouter(rootController: rootController)
        let coordinator = coordinatorFactory.makeTabBarCoordinatorBox(router: tabBarRouter)
        coordinator.onEvent = { [weak coordinator, weak self] event in
            guard let self = self else { return }
            switch event {
            case .onLogout:
                self.swapRootController()
            case .onLanguageReload:
                self.swapRootController(with: .transitionCrossDissolve)
            case .onThemeReload:
                self.swapRootController(with: .transitionCrossDissolve)
            }
            self.removeDependency(coordinator)
        }

        addDependency(coordinator)
        coordinator.start(deepLinkOption: deepLinkOption)

        return rootController
    }

    private func makeAppStartViewController() -> AppStartViewController {
        let viewModel = AppStartViewModel()
        return AppStartViewController(viewModel: viewModel)
    }

    private func swapRootController(with animation: UIView.AnimationOptions = .transitionFlipFromRight, duration: TimeInterval = 0.5) {
        guard let window = UIWindow.key else { return }
        let rootController = getStartCoordinatorBaseController()
        window.rootViewController = rootController
        // Though `animations` is optional, the documentation tells us that it must not be nil
        UIView.transition(with: window, duration: duration, options: animation, animations: {}, completion: nil)
    }
}
