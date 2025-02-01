//
//  SearchVC.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit

final class SearchVC: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<SearchSection, SearchItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>

    private let viewModel: SearchVM
    private var dataSource: DataSource!

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        view.delegate = self
        view.isPrefetchingEnabled = true
        view.prefetchDataSource = self
        return view
    }()

    init(viewModel: SearchVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        view.addSubview(collectionView)

        configureDataSourceProvider()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

// MARK: - Snapshot

extension SearchVC {
    @MainActor
    private func applySnapshot(with sections: [SearchSection]) {
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

extension SearchVC: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSourcePrefetching

extension SearchVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

    }
}

// MARK: - DataSource
extension SearchVC {
    func configureDataSourceProvider() {
        let itemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchItem> { cell, indexPath, item in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: itemRegistration, for: indexPath, item: itemIdentifier)
        }
    }
}
