//
//  SearchViewModelTest.swift
//  githubapiTests
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class SearchViewModelTest: XCTestCase {
    
    var viewModel: SearchViewModel!
    var mockDelegate: MockSearchView!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
        mockDelegate = MockSearchView()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchButtonClickedNilValues() {
        viewModel.searchButtonClicked(projectName: nil, repoName: nil)
        XCTAssert(mockDelegate.showAlertMessage == "Project or repo name cannot be blank.")
    }
    
    func testSearchButtonClickedBlankValues() {
        viewModel.searchButtonClicked(projectName: "", repoName: "")
        XCTAssert(mockDelegate.showAlertMessage == "Project or repo name cannot be blank.")
    }
    
    func testSearcgButtonWithValidValues() {
        viewModel.searchButtonClicked(projectName: "kumarjaspreet", repoName: "githubapi")
        XCTAssertNil(mockDelegate.showAlertMessage)
    }
}

class MockSearchView: SeacrhGithubView {
    
    var showAlertMessage: String?
    func showAlert(message: String) {
        showAlertMessage = message
    }
}
