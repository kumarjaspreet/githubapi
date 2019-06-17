//
//  SearchViewControllerTest.swift
//  githubapiTests
//
//  Created by Jaspreet Kumar. on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class SearchViewControllerTest: XCTestCase {
    
    var viewController: SearchViewController!
    var mockViewModel: MockSearchViewModel!
    
    override func setUp() {
        super.setUp()
        viewController = SearchViewController()
        mockViewModel = MockSearchViewModel()
        viewController.viewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchButtonClicked() {
        let projectTextField = UITextField()
        let repoTextField = UITextField()
        viewController.projectNameTextField = projectTextField
        viewController.repoNameTextField = repoTextField
        viewController.searchButtonClicked(UIButton())
        XCTAssertTrue(mockViewModel.searchButtonClicked)
    }
}

class MockSearchViewModel: GithubSearchViewModel {
    var delegate: SeacrhGithubView? = nil
    
    var searchButtonClicked = false
    
    func searchButtonClicked(projectName: String?, repoName: String?) {
        searchButtonClicked = true
    }
}
