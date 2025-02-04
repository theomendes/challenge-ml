//
//  SwiftUIHostCVC.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 01/02/25.
//

import UIKit
import SwiftUI

final class SwiftUIHostCVC<Content: View>: UICollectionViewCell {
    var hostingController = UIHostingController<Content?>(rootView: nil)

    func configure(with view: Content, in parent: UIViewController?) {
        guard let parent = parent else {
            let message = "parent viewController is required"
            assertionFailure(message)
            return
        }

        hostingController.rootView = view
        hostingController.view.invalidateIntrinsicContentSize()

        let requiresControllerMove = hostingController.parent != parent

        if requiresControllerMove {
            removeHostingControllerFromParent()
            parent.addChild(hostingController)
        }

        if !contentView.subviews.contains(hostingController.view) {
            setupUI()
        }

        if requiresControllerMove {
            hostingController.didMove(toParent: parent)
        }
    }

    private func setupUI() {
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingController.view)
        hostingController.view.backgroundColor = .clear

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    private func removeHostingControllerFromParent() {
        hostingController.willMove(toParent: nil)
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
    }

    deinit {
        removeHostingControllerFromParent()
    }
}
