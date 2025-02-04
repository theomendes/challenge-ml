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
