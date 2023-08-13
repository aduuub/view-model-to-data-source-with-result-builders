//
//  HomePresenter.swift
//  Test
//
//  Created by Adam Wareing on 11/8/2023.
//

import Foundation
import Combine

enum HomeViewSection {
    case banner
    case forYou
    case suggested
}

enum HomeViewItem: Hashable {
    case banner(String)
    case videoContent(String)
    case imageContent(String)
}

class HomePresenter {
        
    var view: HomeViewProtocol?
    
    private let viewModel = ViewModel<HomeViewSection, HomeViewItem>()
    private let homeRepository: HomeRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var homeContent: [String] = []
    
    init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }
    
    func load() {
        homeRepository.getHomeContent()
            .sink(receiveValue: { [weak self] in
                self?.homeContent = $0
                self?.reloadUI()
            })
            .store(in: &cancellables)
    }
    
    private func reloadUI() {
        viewModel.build {
            viewModel.section(.banner) {
                HomeViewItem.banner("This is a banner")
            }
            viewModel.section(.suggested) {
                for content in homeContent {
                    HomeViewItem.imageContent(content)
                }
            }
        }
        view?.apply(viewModel: viewModel)
    }
}
