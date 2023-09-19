//
//  SceneDelegate.swift
//  News_app
//
//  Created by terry on 2023/09/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: NewsListViewController())
        window?.backgroundColor = .systemBackground
		window?.tintColor = .systemOrange
		
        window?.makeKeyAndVisible()
    }
}
