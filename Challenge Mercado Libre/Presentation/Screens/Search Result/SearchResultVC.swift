//
//  SearchVC.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit
import OSLog

final class SearchResultVC: BaseVC {
    typealias DataSource = UICollectionViewDiffableDataSource<SearchResultSection, SearchResultItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchResultSection, SearchResultItem>

    let viewModel: SearchResultVM
    var dataSource: DataSource!
    let logger = Logger(subsystem: "com.theo.Challenge-Mercado-Libre", category: "SearchResultVC")

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        view.delegate = self
        view.isPrefetchingEnabled = true
        view.prefetchDataSource = self
        view.backgroundColor = .white
        return view
    }()

    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: SearchResultVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        super.setupUI()
        view.addSubview(collectionView)
        view.addSubview(loadingView)
        view.addSubview(errorView)

        title = viewModel.query.text
        view.backgroundColor = .white

        configureDataSourceProvider()

        getResults(isLoadingMore: false)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapShowFilter)
        )
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),

            loadingView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),

            errorView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            errorView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor)
        ])
    }

    func getResults(isLoadingMore: Bool) {
        Task {
            showIsLoading(!isLoadingMore)
            do {
                try await viewModel.fetchResults(loadMore: isLoadingMore)
            } catch let error as SearchError {
                showError(error)
            } catch {
                showError(.generic)
            }


            await applySnapshot(with: viewModel.items)
            showIsLoading(false)
        }
    }

    @MainActor
    func showIsLoading(_ loading: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.loadingView.alpha = loading ? 1 : 0
        } completion: { [weak self] _ in
            self?.loadingView.isHidden = !loading
        }
    }

    @MainActor
    func showError(_ error: SearchError?) {
        if let error {
            errorView.setError(error)
        }

        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorView.alpha = error == nil ? 0 : 1
        } completion: { [weak self] _ in
            self?.errorView.isHidden = error == nil
        }
    }

    @objc
    private func didTapShowFilter() {
        goToFilter(with: viewModel.filters)
    }
}
