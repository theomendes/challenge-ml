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

        @Injected(\.networkProvider) var networkProvider

        let repository = SearchResultRepository(service: networkProvider.searchService)
        let useCase = SearchUseCase(repository: repository)
        let viewModel = SearchResultVM(useCase: useCase)

        window?.rootViewController = UINavigationController(rootViewController: SearchResultVC(viewModel: viewModel))

        window?.makeKeyAndVisible()
    }
}
