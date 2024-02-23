import UIKit
import SnapKit

class BaseTextFieldView: UIView {
    
    // MARK: - Closures

    var didChangeTextFieldText: ((String) -> Void)?
    
    // MARK: - Public Properties
    
    var errorMessage: String? = nil {
        didSet {
            errorLabel.text = errorMessage
            errorLabel.isHidden = errorMessage == nil
            updateAppearance()
            layoutIfNeeded()
        }
    }
    
    var textFieldText: String? {
        didSet {
            textField.text = textFieldText
            updateRightActions()
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle == nil
        }
    }
    
    var placeholderText: String? {
        didSet {
            textField.placeholder = placeholderText
        }
    }
    
    var customRightActions: [UIView] = .init() {
        didSet {
            updateRightActions()
        }
    }
    
    var isShowCloseButton: Bool = true {
        didSet {
            updateRightActions()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            updateRightActions()
        }
    }
    
    // MARK: - Private properties
    
    private(set) lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.delegate = self
        return textField
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private(set) var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        return stackView
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private lazy var leftActionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.addArrangedSubview(searchAction)
        return stackView
    }()
    
    private lazy var rightActionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var closeAction: BaseTextFieldActionView = {
        let view = BaseTextFieldActionView()
        #warning("something with images")
        view.updateButtonImage(buttonImage: UIImage(named: "base_icon_close") ?? UIImage())
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clearInput)))
        return view
    }()
    
    private lazy var searchAction: BaseTextFieldActionView = {
        let view = BaseTextFieldActionView()
        #warning("something with images")
        view.updateButtonImage(buttonImage: UIImage(named: "base_icon_search") ?? UIImage())
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(title: String? = nil, subtitle: String? = nil) {
        super.init(frame: .zero)
        
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle == nil
        
        titleLabel.text = title
        subtitleLabel.isHidden = subtitle == nil
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        addSubview(container)
        container.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(titleStack.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        container.addSubview(rightActionsStackView)
        rightActionsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        
        container.addSubview(leftActionsStackView)
        leftActionsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        container.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(leftActionsStackView.snp.trailing)
            make.trailing.equalTo(rightActionsStackView.snp.leading)
        }

        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(container.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateRightActions(textFieldText: String? = nil) {
        rightActionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let textFieldText = textFieldText ?? textField.text ?? ""
        
        func setupActions() {
            for action in customRightActions {
                rightActionsStackView.addArrangedSubview(action)
            }
        }
        
        if isSelected {
            if textFieldText.isEmpty {
                setupActions()
            } else {
                if isShowCloseButton {
                    rightActionsStackView.addArrangedSubview(closeAction)
                } else {
                    setupActions()
                }
            }
        } else {
            if textFieldText.isEmpty {
                setupActions()
            } else {
                if isShowCloseButton {
                    rightActionsStackView.addArrangedSubview(closeAction)
                } else {
                    setupActions()
                }
            }
        }
        
        calculateActionStackWidth()
    }
    
    func calculateActionStackWidth() {
        let isLeftEmptyActions: Bool = leftActionsStackView.arrangedSubviews.isEmpty
        let isRightEmptyActions: Bool = rightActionsStackView.arrangedSubviews.isEmpty
        
        textField.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            
            if isLeftEmptyActions {
                make.leading.equalToSuperview()
            } else {
                make.leading.equalTo(leftActionsStackView.snp.trailing)
            }
            
            if isRightEmptyActions {
                make.trailing.equalToSuperview()
            } else {
                make.trailing.equalTo(rightActionsStackView.snp.leading)
            }
        }
    }
    
    private func updateAppearance() {
        if errorMessage != nil {
            container.layer.borderColor = UIColor.red.cgColor
        } else {
            container.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @objc func clearInput() {
        errorMessage = nil
        textField.text = nil
        didChangeTextFieldText?("")
        updateRightActions()
    }
}

extension BaseTextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        didChangeTextFieldText?(newText)
        updateRightActions(textFieldText: newText)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isSelected = false
    }
}
