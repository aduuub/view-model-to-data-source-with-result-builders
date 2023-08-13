//
//  SceneDelegate.swift
//  Test
//
//  Created by Adam Wareing on 13/8/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navController: UINavigationController?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        self.navController = UINavigationController()
        self.navController?.pushViewController(ViewControllerFactory.homeViewController(), animated: true)
        self.window?.rootViewController = self.navController
    }
}
