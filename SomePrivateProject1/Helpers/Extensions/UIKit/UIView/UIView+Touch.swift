import UIKit

final class ClosureSleeve {

    // MARK: - Properties

    private let closure: () -> Void

    // MARK: - Life Cycle

    init (_ closure: @escaping () -> Void) {
        self.closure = closure
    }

    // MARK: - Selectors

    @objc func invoke () {
        closure()
    }

}

extension UIView {
    
    fileprivate struct Keys {
        static var tapGestureRecognizer = "AssociatedObject.Key.ClosureSleeve"
    }

    // MARK: - Public Methods

    @objc @discardableResult
    func onTouchUpInside(cancelTouchesInView: Bool = false, _ action: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        addTapGestureRecognizer(cancelTouchesInView: cancelTouchesInView, action: action)
        return self
    }
    
    // MARK: - Private Methods

    fileprivate func addTapGestureRecognizer(cancelTouchesInView: Bool, action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(action)
        objc_setAssociatedObject(
            self, Keys.tapGestureRecognizer, sleeve,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
        let tapGestureRecognizer = UITapGestureRecognizer(target: sleeve, action: #selector(ClosureSleeve.invoke))
        tapGestureRecognizer.delegate = self
        tapGestureRecognizer.cancelsTouchesInView = cancelTouchesInView
        addGestureRecognizer(tapGestureRecognizer)
    }
}

class AnimatedTouchLongPressGesture: UILongPressGestureRecognizer { }

extension UIView: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer is AnimatedTouchLongPressGesture
    }

}
