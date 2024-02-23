import UIKit

final class CategoriesListViewController: BaseViewController {
    
    // MARK: - Closure
    
    var onCategoryPressed: ((FoodCategoryModel) -> Void)?
    
    // MARK: - Private Properties
    
    private lazy var searchTextFieldView: BaseTextFieldView = {
        let view = BaseTextFieldView()
        view.placeholderText = "Search in Uber Eats"
        view.didChangeTextFieldText = { [weak self] text in
            guard let self else { return }
            self.filterItems(text: text)
        }
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(
            CategoriesListCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesListCategoryCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            CategoriesListEmptyCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoriesListEmptyCollectionReusableView.reuseIdentifier
        )
        collectionView.register(
            CategoriesListTitleCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoriesListTitleCollectionReusableView.reuseIdentifier
        )
        return collectionView
    }()
    
    private let viewModel: CategoriesListViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: CategoriesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        Task { [weak self] in
            guard let self else { return }
            await viewModel.setupDataSource()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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
        
        view.addSubview(searchTextFieldView)
        searchTextFieldView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextFieldView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func filterItems(text: String) {
        viewModel.filterByName(text: text)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CategoriesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.tableTemplate[indexPath.section]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesListCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoriesListCategoryCollectionViewCell else {
            fatalError("Failed to dequeue cell with identifier: " + CategoriesListCategoryCollectionViewCell.reuseIdentifier)
        }
        
        let category: FoodCategoryModel?
        switch section {
        case .all:
            category = viewModel.filteredAllFoodCategories[indexPath.row]
        case .popular:
            category = viewModel.filteredPopularFoodCategories[indexPath.row]
        case .empty:
            category = nil
        }
        
        if let category {
            cell.setup(imageURL: category.imageURL, titleText: category.title)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.tableTemplate[indexPath.section]
        switch section {
        case .all:
            let model = viewModel.filteredAllFoodCategories[indexPath.row]
            onCategoryPressed?(model)
        case .popular:
            let model = viewModel.filteredPopularFoodCategories[indexPath.row]
            onCategoryPressed?(model)
        case .empty:
            break
        }
    }
}

extension CategoriesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CategoriesListViewModel.Sizes.itemWidth, height: CategoriesListCategoryCollectionViewCell.possibleHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CategoriesListViewModel.Sizes.interItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CategoriesListViewModel.Sizes.interLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.tableTemplate[indexPath.section]
        if kind == UICollectionView.elementKindSectionHeader {
            switch section {
            case .empty:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: CategoriesListEmptyCollectionReusableView.reuseIdentifier,
                    for: indexPath
                ) as? CategoriesListEmptyCollectionReusableView else {
                    return UICollectionReusableView()
                }
                return headerView
            case .all, .popular:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: CategoriesListTitleCollectionReusableView.reuseIdentifier,
                    for: indexPath
                ) as? CategoriesListTitleCollectionReusableView else {
                    return UICollectionReusableView()
                }
                headerView.setupReusableView(titleText: section.sectionTitle)
                return headerView
            }
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = viewModel.tableTemplate[section]
        
        switch section {
        case .empty:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case .all, .popular:
            return CGSize(width: collectionView.frame.width, height: 30)
        }
    }
}
