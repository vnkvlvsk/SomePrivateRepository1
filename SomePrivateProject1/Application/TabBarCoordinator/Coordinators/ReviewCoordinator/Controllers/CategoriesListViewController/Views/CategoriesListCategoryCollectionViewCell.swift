import UIKit
import SnapKit
import Kingfisher

final class CategoriesListCategoryCollectionViewCell: UICollectionViewCell {
    
    #warning("do something")
    static var reuseIdentifier: String = "CategoriesListCategoryCollectionViewCell"
    
    static var possibleHeight: CGFloat {
        return 80 + 8 + 8 + 20
    }
    
    // MARK: - Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setup(imageURL: URL, titleText: String) {
        categoryImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholderImage"))
        titleLabel.text = titleText
    }

    // MARK: - Private methods

    private func configureUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(categoryImageView)
        categoryImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = nil
        titleLabel.text = nil
    }
}
