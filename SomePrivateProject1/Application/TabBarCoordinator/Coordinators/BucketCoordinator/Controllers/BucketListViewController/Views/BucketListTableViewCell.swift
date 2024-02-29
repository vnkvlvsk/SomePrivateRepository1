import UIKit

final class BucketListTableViewCell: UITableViewCell {
    
    #warning("do something")
    static var reuseIdentifier: String = "BucketListTableViewCell"
    
    // MARK: - Closure
    
    var onMoreButtonPressed: (() -> Void)?
    var onShowBucketButtonPressed: (() -> Void)?
    var onInRestaurantButtonPressed: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.addArrangedSubview(restaurantNameLabel)
        stackView.addArrangedSubview(positionNumberAndPriceLabel)
        stackView.addArrangedSubview(deliveryAddressLabel)
        return stackView
    }()
    
    private let restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let positionNumberAndPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let deliveryAddressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let workingHoursLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "ellipsis")
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemGray5
        button.onTouchUpInside { [weak self] in
            guard let self else { return }
            self.onMoreButtonPressed?()
        }
        return button
    }()
    
    private lazy var primaryButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(showBucketButton)
        stackView.addArrangedSubview(inRestaurantButton)
        return stackView
    }()
    
    private lazy var showBucketButton: UIButton = {
        let button = UIButton()
        let title = "Show bucket"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        button.setAttributedTitle(NSAttributedString(string: title, attributes: attributes), for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .black
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.onTouchUpInside { [weak self] in
            guard let self else { return }
            self.onShowBucketButtonPressed?()
        }
        return button
    }()
    
    private lazy var inRestaurantButton: UIButton = {
        let button = UIButton()
        let title = "In restaurant"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        button.setAttributedTitle(NSAttributedString(string: title, attributes: attributes), for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray5
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.onTouchUpInside { [weak self] in
            guard let self else { return }
            self.onInRestaurantButtonPressed?()
        }
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setupCell(bucketModel: BucketModel) {
        restaurantImageView.kf.setImage(with: bucketModel.restaurantImageURL, placeholder: UIImage(named: "placeholderImage"))
        restaurantNameLabel.text = bucketModel.restaurantName
        positionNumberAndPriceLabel.text = "\(bucketModel.positionNumber) position·\(bucketModel.price)"
        deliveryAddressLabel.text = "Delivery address: \(bucketModel.deliveryAddress)"
        if !bucketModel.isOpened {
            informationStackView.addArrangedSubview(workingHoursLabel)
            workingHoursLabel.text = "·Opens: \(bucketModel.workingHours.start)"
        }
    }
    
    // MARK: - Private methods
    
    @objc private func moreButtonPressed() {
        onMoreButtonPressed?()
    }
    
    @objc private func showBucketButtonPressed() {
        onShowBucketButtonPressed?()
    }
    
    @objc private func inRestaurantButtonPressed() {
        onInRestaurantButtonPressed?()
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(restaurantImageView)
        containerView.addSubview(informationStackView)
        containerView.addSubview(moreButton)
        containerView.addSubview(primaryButtonsStackView)
        
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().inset(16)
        }
        
        restaurantImageView.snp.makeConstraints { make in
            make.centerY.equalTo(informationStackView)
            make.size.equalTo(60)
            make.leading.equalToSuperview().offset(16)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(restaurantImageView.snp.trailing).offset(8)
            make.trailing.equalTo(moreButton.snp.leading).offset(-8)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(restaurantImageView)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(30)
        }
        
        primaryButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(informationStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        restaurantImageView.image = nil
//        informationStackView.arrangedSubviews.forEach({ informationStackView.removeArrangedSubview($0); $0.removeFromSuperview() })
//        restaurantNameLabel.text = nil
//        deliveryAddressLabel.text = nil
//        workingHoursLabel.text = nil
//        primaryButtonsStackView.arrangedSubviews.forEach({ primaryButtonsStackView.removeArrangedSubview($0); $0.removeFromSuperview() })
    }
}
