//
//  TestTests.swift
//  TestTests
//
//  Created by Adam Wareing on 11/8/2023.
//

import XCTest
@testable import Test

final class HomeTests: XCTestCase {

    var presenter: HomePresenter!
    var view: MockHomeView!
    
    override func setUp() async throws {
        self.presenter = HomePresenter(homeRepository: HomeRepository())
        self.view = MockHomeView()
        presenter.view = view
    }
    
    func testViewModel() throws {
        let expectedViewModelString = "banner section: [Test.HomeViewItem.banner(\"This is a banner\")]suggested section: [Test.HomeViewItem.imageContent(\"Item 1\"), Test.HomeViewItem.imageContent(\"Item 2\")]"
        
        let expectedViewModel = expectation(description: "expected correct view model")
        view.applyViewModel = { viewModel in
            XCTAssertEqual(viewModel.debugString(), expectedViewModelString)
            expectedViewModel.fulfill()
        }
        
        presenter.load()
        wait(for: [expectedViewModel], timeout: 5)
    }
}

class MockHomeView: HomeViewProtocol {
    
    var applyViewModel: ((Test.ViewModel<Test.HomeViewSection, Test.HomeViewItem>) -> Void)?
    
    func apply(viewModel: Test.ViewModel<Test.HomeViewSection, Test.HomeViewItem>) {
        applyViewModel?(viewModel)
    }
}
