//
//  ProductDetailVCWrapper.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 02/02/25.
//

import SwiftUI

final class ProductDetailVCWrapper: UIHostingController<ProductDetailScreen> {
    let standard: UINavigationBarAppearance = {
        let app = UINavigationBarAppearance()
        app.configureWithOpaqueBackground()
        return app
    }()

    let backBarBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return button
    }()

    init(item: SearchResultItem) {
        let screen = ProductDetailScreen(item: item)
        super.init(rootView: screen)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearence()
    }

    func setupAppearence() {
        let standardYellow = UIColor.mlYellow
        let standardBlue = UIColor.mlBlue

        standard.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]

        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [
            .foregroundColor: standardYellow
        ]
        button.highlighted.titleTextAttributes = [
            .foregroundColor: standardBlue
        ]
        standard.buttonAppearance = button

        let done = UIBarButtonItemAppearance(style: .done)
        done.normal.titleTextAttributes = [
            .foregroundColor: standardBlue
        ]
        standard.doneButtonAppearance = done
        standard.backgroundColor = standardYellow

        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        navigationItem.compactAppearance = standard
        navigationController?.navigationBar.tintColor = standardBlue
        navigationItem.backBarButtonItem = backBarBtn
    }
}
