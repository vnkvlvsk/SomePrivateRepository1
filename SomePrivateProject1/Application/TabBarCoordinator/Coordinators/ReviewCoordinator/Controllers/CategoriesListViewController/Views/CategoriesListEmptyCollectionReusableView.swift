import UIKit

final class CategoriesListEmptyCollectionReusableView: UICollectionReusableView {
    
    #warning("do something")
    static var reuseIdentifier: String = "CategoriesListEmptyCollectionReusableView"
    
    // MARK: - Private properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wrench.and.screwdriver")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        imageView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .systemGray3
        label.text = "Oops, something went wrong!"
        return label
    }()
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
