//
//  HomeRepository.swift
//  Test
//
//  Created by Adam Wareing on 12/8/2023.
//

import Foundation
import Combine

protocol HomeRepositoryProtocol: AnyObject {
    func getHomeContent() -> AnyPublisher<[String], Never>
}

class HomeRepository: HomeRepositoryProtocol {
    
    var timer: Timer?
    
    func getHomeContent() -> AnyPublisher<[String], Never> {
        return Just(["Item 1", "Item 2"]).eraseToAnyPublisher()
    }
}
