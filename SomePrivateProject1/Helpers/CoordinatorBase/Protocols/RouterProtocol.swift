import Foundation
import UIKit

protocol RouterProtocol: Presentable {

    func present(_ controller: Presentable?)
    func present(_ controller: Presentable?, animated: Bool, completionHandler: (() -> Void)?)
    func present(_ controller: Presentable?, presentationStyle: UIModalPresentationStyle, animated: Bool, completionHandler: (() -> Void)?)

    func push(_ controller: Presentable?)
    func push(_ controller: Presentable?, hideBottomBar: Bool)
    func push(_ controller: Presentable?, animated: Bool)
    func push(_ controller: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ controller: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)

    func popController()
    func popController(animated: Bool)

    func dismissController()
    func dismissController(animated: Bool, completion: (() -> Void)?)

    func setRootController(_ controller: Presentable?)
    func setRootController(_ controller: Presentable?, hideBar: Bool)

    func popToRootController(animated: Bool)
}
