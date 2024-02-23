import UIKit

final class BucketListViewController: BaseViewController {
    
    // MARK: - Closure
    
    var onOrderButtonPressed: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Buckets"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var orderButtonView: BucketListShowOrderButtonView = {
        let view = BucketListShowOrderButtonView()
        view.onTouchUpInside { [weak self] in
            guard let self else { return }
            self.onOrderButtonPressed?()
        }
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        tableView.alwaysBounceVertical = true
        tableView.estimatedSectionHeaderHeight = CGFloat.leastNonzeroMagnitude
        tableView.estimatedSectionFooterHeight = CGFloat.leastNonzeroMagnitude
        tableView.register(BucketListTableViewCell.self, forCellReuseIdentifier: BucketListTableViewCell.reuseIdentifier)
        tableView.register(BucketListEmptyHeaderView.self, forHeaderFooterViewReuseIdentifier: BucketListEmptyHeaderView.reuseIdentifier)
        return tableView
    }()
    
    private let viewModel: BucketListViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: BucketListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupDataSource()
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
        view.addSubview(titleLabel)
        view.addSubview(orderButtonView)
        view.addSubview(tableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        orderButtonView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(orderButtonView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupDataSource() {
        Task.detached { [weak self] in
            guard let self = self else { return }
            do {
                try await self.viewModel.setupDataSource()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("BucketListViewController.setupDataSource error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BucketListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.reuseIdentifier) as? BucketListTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(bucketModel: viewModel.dataSource[indexPath.row])
        
        cell.onMoreButtonPressed = { [weak self] in
            guard let self = self else { return }
            print("onMoreButtonPressed")
        }
        
        cell.onShowBucketButtonPressed = { [weak self] in
            guard let self = self else { return }
            print("onShowBucketButtonPressed")
        }
        
        cell.onInRestaurantButtonPressed = { [weak self] in
            guard let self = self else { return }
            print("onInRestaurantButtonPressed")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.dataSource.isEmpty else { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BucketListEmptyHeaderView.reuseIdentifier) as? BucketListEmptyHeaderView else {
            return nil
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.dataSource.isEmpty else { return .leastNonzeroMagnitude }
        return tableView.bounds.height - 40
    }
}
