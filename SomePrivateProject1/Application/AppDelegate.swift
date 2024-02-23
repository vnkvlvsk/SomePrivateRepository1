import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    lazy var applicationCoordinator: AppCoordinator = {
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window!, coordinatorFactory: AppCoordinatorFactory())
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start(deepLinkOption: nil)
        return true
    }
}

