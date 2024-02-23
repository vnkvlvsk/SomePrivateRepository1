import UIKit

class BaseTextFieldActionView: UIView {
    
    // MARK: - Interface
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.tintColor = .black
        return imageView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func updateButtonImage(buttonImage: UIImage) {
        imageView.image = buttonImage
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.edges.equalToSuperview()
        }
    }
}
