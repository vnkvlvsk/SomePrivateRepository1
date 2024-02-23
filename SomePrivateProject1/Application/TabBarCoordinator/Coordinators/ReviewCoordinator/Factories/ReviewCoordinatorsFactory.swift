import Foundation

final class ReviewCoordinatorsFactory {
    
    func makeCategoriesListViewController() -> CategoriesListViewController {
        let viewModel = CategoriesListViewModel()
        return CategoriesListViewController(viewModel: viewModel)
    }
}
