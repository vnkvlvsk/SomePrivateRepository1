import UIKit

final class CategoriesListTitleCollectionReusableView: UICollectionReusableView {
    
    #warning("do something")
    static var reuseIdentifier: String = "CategoriesListTitleCollectionReusableView"
    
    // MARK: - Private properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
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
    
    // MARK: - Public methods
    
    func setupReusableView(titleText: String?) {
        titleLabel.text = titleText
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
