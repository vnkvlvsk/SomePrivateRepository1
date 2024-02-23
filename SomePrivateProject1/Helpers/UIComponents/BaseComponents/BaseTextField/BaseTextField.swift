import UIKit

class BaseTextField: UITextField {
    
    // MARK: - Properties
    
    override var placeholder: String? {
        set {
            guard let newValue = newValue else {
                attributedPlaceholder = nil
                return
            }
            
            attributedPlaceholder = NSAttributedString(string: newValue, attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.systemGray
                ]
            )
        }
        get { super.placeholder }
    }
    
    private(set) var padding = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // MARK: - Private methods
    
    private func setupUI() {
        font = .systemFont(ofSize: 16)
        tintColor = .black
    }
}
