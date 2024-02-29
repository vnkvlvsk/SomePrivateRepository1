import UIKit

final class AccountSettingsTitleView: UIView {
    
    // MARK: - Closure
    
    var onAvatarPressed: (() -> Void)?
    
    // MARK: - Private properties
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray3
        imageView.tintColor = .black
        imageView.onTouchUpInside { [weak self] in
            guard let self else { return }
            self.onAvatarPressed?()
        }
        return imageView
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.text = "nameTitleLabel"
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
        
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setupUserInfo(name: String, surname: String, avatar: UIImage?) {
        nameTitleLabel.text = "\(name.capitalized) \(surname.capitalized)"
        avatarImageView.image = avatar ?? UIImage(systemName: "person")
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(nameTitleLabel)
        addSubview(avatarImageView)
        
        nameTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(avatarImageView.snp.leading).offset(8)
            make.centerY.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.size.equalTo(60)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
