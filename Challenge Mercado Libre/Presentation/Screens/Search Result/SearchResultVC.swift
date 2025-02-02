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

    private let viewModel: SearchResultVM
    private var dataSource: DataSource!
    private let logger = Logger(subsystem: "com.theo.Challenge-Mercado-Libre", category: "SearchResultVC")

    private lazy var collectionView: UICollectionView = {
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

        title = viewModel.query.text
        view.backgroundColor = .white

        configureDataSourceProvider()

        Task {
            showIsLoading(true)
            await viewModel.fetchResults()

            await applySnapshot(with: viewModel.sections)
        }
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
            loadingView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor)
        ])
    }

    @MainActor
    private func showIsLoading(_ loading: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.loadingView.alpha = loading ? 1 : 0
        } completion: { [weak self] _ in
            self?.loadingView.isHidden = !loading
        }
    }
}

// MARK: - Snapshot

extension SearchResultVC {
    @MainActor
    private func applySnapshot(with sections: [SearchResultSection]) async {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach {
            snapshot.appendItems($0.items)
        }

        dataSource.apply(snapshot, animatingDifferences: true) { [weak self] in
            self?.showIsLoading(false)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchResultVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        logger.log(level: .info, "Did select item with ID: \(selectedItem.id)")
        goToDetail(for: selectedItem)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension SearchResultVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

    }
}

// MARK: - DataSource
extension SearchResultVC {
    func configureDataSourceProvider() {
        let itemRegistration = UICollectionView.CellRegistration<SwiftUIHostCVC<SearchResultItemView>, SearchResultItem> { [weak self] cell, indexPath, item in
            cell.configure(with: .init(item: item), in: self)
        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: itemRegistration, for: indexPath, item: itemIdentifier)
        }
    }
}

// MARK: - Layout

extension SearchResultVC {
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 40

        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )

            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)

            return section
        }, configuration: config)
    }
}

extension SearchResultVC {
    func goToDetail(for item: SearchResultItem) {
        let vc = ProductDetailVCWrapper(item: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
