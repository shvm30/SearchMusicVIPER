//
//  SceneDelegate.swift
//  WheatherApp
//
//  Created by Владимир on 12.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let songsViewDontroller = SongsViewModuleBuilder.shared.createSongsViewContoller()
        navigationController.viewControllers = [songsViewDontroller]
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

