import Foundation
import UIKit

final class TabBarItem: Presentable {

    // MARK: - Properties

    var presentable: Presentable?
    var tabBarItemTitle: String?

    // MARK: - Lifecycle

    init(presentable: Presentable?, tabBarItemTitle: String?, image: UIImage, tag: Int) {
        self.presentable = presentable
        self.tabBarItemTitle = tabBarItemTitle
        guard let presentableController = presentable?.toPresent() else { return }
        let tabBarItem = UITabBarItem(title: tabBarItemTitle, image: image, tag: tag)
        
        tabBarItem.badgeColor = .systemGreen
        tabBarItem.imageInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        presentableController.tabBarItem = tabBarItem
    }

    // MARK: - Presentable

    func toPresent() -> UIViewController? {
        return presentable?.toPresent()
    }
}
