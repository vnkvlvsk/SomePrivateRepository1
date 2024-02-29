import UIKit

class BaseNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let navBarAppearance = UINavigationBarAppearance()
        navigationBar.standardAppearance = navBarAppearance
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
