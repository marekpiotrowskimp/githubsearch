//
//  SceneDelegate.swift
//  github
//
//  Created by Marek Piotrowski-EXT on 27/02/2020.
//  Copyright © 2020 Marek Piotrowski. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let githubViewModel = GithubMainViewModel()
        let githubViewController = GithubMainViewController(viewModel: githubViewModel)
        let navigationController = UINavigationController(rootViewController: githubViewController)
        window?.rootViewController = navigationController
        window?.rootViewController?.view.backgroundColor = UIColor.red
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

