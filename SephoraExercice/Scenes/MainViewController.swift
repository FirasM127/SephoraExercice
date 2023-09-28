//
//  MainViewController.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import UIKit
import Combine
import Domain

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    
    var viewModel: MainViewModel
    private let refreshControl = UIRefreshControl()
    private let input: PassthroughSubject<MainViewModel.Input, Never> = .init()
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ProductViewModel>
    private typealias DataSource = UITableViewDiffableDataSource<Section, ProductViewModel>
    private var dataSource: DataSource?
    private var subscriptions = Set<AnyCancellable>()
    
    enum Section: CaseIterable {
        case product
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set navigation item title
        navigationItem.title = "Sephora"
        setupTabbleView()
        // Calling user defined methods
        subscribeViewModel()
        registerTableViewCell()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.load)
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTabbleView() {
        view.addSubview(tableView)
        
        // Set constraints for the table view (optional, you can use Auto Layout)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func registerTableViewCell() {
        tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        dataSource = DataSource(tableView: tableView, cellProvider: {(tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else {
                return UITableViewCell()
            }
            cell.updateView(item)
            return cell
        })
    }
}

extension MainViewController {
    // MARK: - Configurators
    
    func update(with products: [ProductViewModel], animate: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(products, toSection: .product)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
}

extension MainViewController {
    // MARK: - Subscribers
    
    private func subscribeViewModel() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] event in
                switch event {
                case .fetchProductsDidSuccess(let products):
                    self?.update(with: products, animate: true)
                case .fetchProductsDidFail(let error):
                    print(error.localizedDescription)
                case .fetchProductsDidFinish:
                    self?.refreshControl.endRefreshing()
                }
            })
            .store(in: &subscriptions)
    }
}

extension MainViewController {
    // MARK: - Action Methods
    
    @objc func pullToRefresh(sender: UIRefreshControl) {
        input.send(.refresh)
    }
}


