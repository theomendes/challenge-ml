//
//  SceneDelegate.swift
//  Challenge Mercado Libre
//
//  Created by Theo Mendes on 31/01/25.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)

        window?.rootViewController = UINavigationController(rootViewController: QueryVC())

        window?.makeKeyAndVisible()

        if let urlContext = connectionOptions.urlContexts.first {
            handleDeepLink(urlContext.url)
        }
    }

    func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    ) {
        guard let url = URLContexts.first?.url else { return }
        handleDeepLink(url)
    }
}

extension SceneDelegate {
    private func handleDeepLink(_ url: URL) {
        guard let deepLink = DeepLink(url: url) else { return }

        guard let navController = window?.rootViewController as? UINavigationController else { return }

        @Injected(\.networkProvider) var networkProvider

        switch deepLink {
        case .search(let query, let siteID, let category):
            let repo = SearchResultRepository(service: networkProvider.searchService)
            let useCase = SearchUseCase(repository: repo)
            let viewModel = SearchResultVM(useCase: useCase, query: .init(text: query, siteID: siteID, category: category))
            let searchVC = SearchResultVC(viewModel: viewModel)
            navController.pushViewController(searchVC, animated: true)
        }
    }
}
