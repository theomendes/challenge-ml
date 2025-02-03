//
//  SearchFilterVC.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 03/02/25.
//

import Foundation
import UIKit

protocol SearchFilterVCDelegate: AnyObject {
    func didSelectedFilter(_ filter: String, from sectionID: String)
    func applyFilters()
    func resetFilters()
}

final class SearchFilterVC: BaseVC {
    typealias DataSource = UICollectionViewDiffableDataSource<SearchResultFilter, SearchResultFilter.Values>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchResultFilter, SearchResultFilter.Values>

    var dataSource: DataSource!
    weak var delegate: SearchFilterVCDelegate?
    var filters: [SearchResultFilter]

    init(filters: [SearchResultFilter]) {
        self.filters = filters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        view.delegate = self
        view.backgroundColor = .white
        return view
    }()

    override func setupUI() {
        super.setupUI()
        view.addSubview(collectionView)
        view.backgroundColor = .white

        configureDataSourceProvider()

        applySnapshot(withSections: filters)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("search_filter_apply", comment: "Apply"),
            style: .done,
            target: self,
            action: #selector(didTapApply))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("search_filter_reset", comment: "Reset"),
            style: .done,
            target: self,
            action: #selector(didTapReset))
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

    @objc
    private func didTapApply() {
        delegate?.applyFilters()
        dismiss(animated: true)
    }

    @objc
    private func didTapReset() {
        delegate?.resetFilters()
        dismiss(animated: true)
    }
}

extension SearchFilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let selectedSection = dataSource.snapshot().sectionIdentifiers[indexPath.section]

        handleSelection(for: selectedItem, in: selectedSection)
    }

    private func handleSelection(for item: SearchResultFilter.Values, in section: SearchResultFilter) {
        if let sectionIndex = filters.firstIndex(where: { $0.id == section.id }) {
            for itemIndex in filters[sectionIndex].values.indices {
                filters[sectionIndex].values[itemIndex].isSelected = false
            }

            if let itemIndex = filters[sectionIndex].values.firstIndex(where: { $0.id == item.id }) {
                filters[sectionIndex].values[itemIndex].isSelected = true
            }

            delegate?.didSelectedFilter(item.idValue, from: section.id)

            applySnapshot(withSections: [])
            applySnapshot(withSections: filters, animatingDifferences: true)
        }
    }
}

extension SearchFilterVC {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .supplementary
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
}

extension SearchFilterVC {
    func configureDataSourceProvider() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { (supplementaryView, _, indexPath) in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            var content = supplementaryView.defaultContentConfiguration()
            content.text = section.name
            supplementaryView.contentConfiguration = content
        }

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResultFilter.Values> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content

            if item.isSelected {
                cell.accessories = [.checkmark()]
            } else {
                cell.accessories = []
            }
        }

        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: SearchResultFilter.Values) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }

    }

    func applySnapshot(withSections sections: [SearchResultFilter], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()

        snapshot.appendSections(sections)

        sections.forEach { section in
            snapshot.appendItems(section.values, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
