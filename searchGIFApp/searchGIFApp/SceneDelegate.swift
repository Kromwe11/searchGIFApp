//
//  SceneDelegate.swift
//  searchGIFApp
//
//  Created by Висент Щепетков on 26.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: GIFListRouter.createGIFListModule())
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
