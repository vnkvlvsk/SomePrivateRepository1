import Foundation

final class AccountSettingsCoordinatorFactory {
    
    func makeAccountSettingsViewController() -> AccountSettingsViewController {
        let viewModel = AccountSettingsViewModel()
        return AccountSettingsViewController(viewModel: viewModel)
    }
}
