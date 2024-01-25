import Foundation
import UIKit

protocol TabBarRouterProtocol: Presentable {
    func present(_ controller: Presentable?)
    func present(_ controller: Presentable?, animated: Bool, completionHandler: (() -> Void)?)
    func present(_ controller: Presentable?, presentationStyle: UIModalPresentationStyle, animated: Bool, completionHandler: (() -> Void)?)
    
    func dismissController()
    func dismissController(animated: Bool, completion: (() -> Void)?)
    
    func set(_ tabBarControllers: [Presentable])
}
