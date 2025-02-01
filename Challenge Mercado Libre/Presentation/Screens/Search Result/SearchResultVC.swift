//
//  SearchVC.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit

final class SearchResultVC: BaseVC {
    typealias DataSource = UICollectionViewDiffableDataSource<SearchResultSection, SearchResultItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchResultSection, SearchResultItem>

    private let viewModel: SearchResultVM
    private var dataSource: DataSource!

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
        title = viewModel.query.text
        view.backgroundColor = .white

        configureDataSourceProvider()

        Task {
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
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

        dataSource.apply(snapshot, animatingDifferences: true) {

        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchResultVC: UICollectionViewDelegate {

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
