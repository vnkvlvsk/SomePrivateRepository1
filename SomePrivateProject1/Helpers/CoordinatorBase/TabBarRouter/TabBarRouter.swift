import Foundation
import UIKit

final class TabBarRouter: NSObject, TabBarRouterProtocol {
    
    weak var rootController: UITabBarController?

    init(rootController: UITabBarController) {
        self.rootController = rootController
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ controller: Presentable?) {
        present(controller, animated: true, completionHandler: nil)
    }
    
    func present(_ controller: Presentable?, animated: Bool, completionHandler: (() -> Void)?) {
        guard let controller = controller?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: completionHandler)
    }
    
    func present(_ controller: Presentable?, presentationStyle: UIModalPresentationStyle, animated: Bool, completionHandler: (() -> Void)?) {
        guard let controller = controller?.toPresent() else { return }
        controller.modalPresentationStyle = presentationStyle
        rootController?.present(controller, animated: animated, completion: completionHandler)
    }
    
    func dismissController() {
        dismissController(animated: true, completion: nil)
    }

    func dismissController(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func set(_ tabBarControllers: [Presentable]) {
        let controllers = tabBarControllers.compactMap({ presentable -> UIViewController? in
            return presentable.toPresent()
        })
        for (i, controller) in controllers.enumerated() {
            controller.tabBarItem.tag = i
        }
        rootController?.viewControllers = controllers
    }
}
