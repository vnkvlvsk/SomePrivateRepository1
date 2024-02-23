import UIKit

final class CategoriesListViewModel {
    
    // MARK: - Public properties
    
    var tableTemplate: [TableSection] {
        var sections: [TableSection] = []
        !popularFoodCategories.isEmpty ? sections.append(.popular) : nil
        !allFoodCategories.isEmpty ? sections.append(.all) : nil
        
        sections.isEmpty ? sections.append(.empty) : nil
        return sections
    }
    
    var filteredPopularFoodCategories: [FoodCategoryModel] = []
    var filteredAllFoodCategories: [FoodCategoryModel] = []
    
    // MARK: - Private properties
    
    private var popularFoodCategories: [FoodCategoryModel] = []
    private var allFoodCategories: [FoodCategoryModel] = []
    
    // MARK: - Public methods
    
    func filterByName(text: String) {
        if text == "" {
            filteredPopularFoodCategories = popularFoodCategories
            filteredAllFoodCategories = allFoodCategories
        } else {
            filteredPopularFoodCategories = popularFoodCategories.filter({ $0.title.contains(text) })
            filteredAllFoodCategories = allFoodCategories.filter({ $0.title.contains(text) })
        }
    }
    
    func numberOfSections() -> Int {
        var numberOfSections = 0
        !filteredPopularFoodCategories.isEmpty ? numberOfSections = numberOfSections + 1 : nil
        !filteredAllFoodCategories.isEmpty ? numberOfSections = numberOfSections + 1 : nil
        return numberOfSections
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let section = tableTemplate[section]
        
        switch section {
        case .popular:
            return filteredPopularFoodCategories.count
        case .all:
            return filteredAllFoodCategories.count
        case .empty:
            return 0
        }
    }
    
    func setupDataSource() async {
        async let popularFoodCategoriesTask = getPopularFoodCategories()
        async let allFoodCategoriesTask = getAllFoodCategories()
        
        do {
            popularFoodCategories = try await popularFoodCategoriesTask
            allFoodCategories = try await allFoodCategoriesTask
            
            filteredPopularFoodCategories = popularFoodCategories
            filteredAllFoodCategories = allFoodCategories
        } catch {
            print("CategoriesListViewModel.setupDataSource \(error.localizedDescription)")
        }
    }
    
    // MARK: - Private methods
    
    private func getPopularFoodCategories() async throws -> [FoodCategoryModel] {
        return try await NetworkService.shared.getPopularFoodCategories()
    }
    
    private func getAllFoodCategories() async throws -> [FoodCategoryModel] {
        return try await NetworkService.shared.getAllFoodCategories()
    }
}

// MARK: - TableSection

extension CategoriesListViewModel {
    enum TableSection {
        case empty
        case popular
        case all
        
        var sectionTitle: String? {
            switch self {
            case .empty:
                return nil
            case .popular:
                return "Popular categories"
            case .all:
                return "All categories"
            }
        }
    }
}

// MARK: - Sizes

extension CategoriesListViewModel {
    enum Sizes {
        static let interItemSpacing: CGFloat = 16
        static let interLineSpacing: CGFloat = 16
        static let itemWidth: CGFloat = UIScreen.main.bounds.width / 2 - (8 + interItemSpacing)
    }
}
