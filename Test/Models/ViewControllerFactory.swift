//
//  ViewControllerFactory.swift
//  Test
//
//  Created by Adam Wareing on 12/8/2023.
//

import Foundation

class ViewControllerFactory {
    
    static func homeViewController() -> HomeViewController {
        let homeVC = HomeViewController()
        let presenter = HomePresenter(homeRepository: HomeRepository())
        presenter.view = homeVC
        homeVC.presenter = presenter
        return homeVC
    }
}
