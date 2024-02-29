import UIKit

final class BucketListShowOrderButtonView: UIView {
    
    // MARK: - Private properties
    
    private let orderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet.clipboard")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Orders"
        label.textAlignment = .center
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
    
    // MARK: - Private methods
    
    private func setupView() {
        layer.cornerRadius = 16
        backgroundColor = .systemGray4
        
        addSubview(orderImageView)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(8)
        }
        
        orderImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-6)
            make.centerY.equalTo(titleLabel)
        }
    }
}
