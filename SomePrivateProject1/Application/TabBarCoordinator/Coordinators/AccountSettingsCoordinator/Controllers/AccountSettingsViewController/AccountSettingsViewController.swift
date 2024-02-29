import Foundation
import UIKit

final class AccountSettingsViewController: BaseViewController {
    
    // MARK: - Closure
    
    var onOrderButtonPressed: (() -> Void)?
    
    // MARK: - Private Properties
    
    private lazy var accountSettingsTitleView: AccountSettingsTitleView = {
        let view = AccountSettingsTitleView()
        view.onAvatarPressed = { [weak self] in
            guard let self else { return }
            print("onAvatarPressed")
        }
        return view
    }()
    
    private let viewModel: AccountSettingsViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: AccountSettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        accountSettingsTitleView.setupUserInfo(name: "ivan", surname: "kavaleuski", avatar: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        hideKeyboardOnTap()
        view.addSubview(accountSettingsTitleView)

        accountSettingsTitleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
