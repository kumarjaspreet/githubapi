//
//  AuthorListViewModelTest.swift
//  githubapiTests
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class AuthorListViewModelTest: XCTestCase {
    
    var viewModel: AuthorListViewModel!
    var mockDelegate: MockAuthorListView!
    var mockManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockManager = MockNetworkManager()
        mockDelegate = MockAuthorListView()
        viewModel = AuthorListViewModel(project: "project", repo: "repo", manager: mockManager)
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockDelegate = nil
    }
    
    func testAutherInfo() {
        viewModel.commitList = mockGitAuthorList
        let authorInfo = viewModel.authorInfo(at: 1)
        XCTAssert(authorInfo.name == "author2")
        XCTAssert(authorInfo.commit == "sha2")
        XCTAssert(authorInfo.message == "message2")
    }
    
    func testViewLoaded() {
        viewModel.currentPage = 3
        viewModel.fetchList()
        XCTAssert(mockManager.repoUrl == "project/repo/commits?per_page=25&page=1")
    }
}

class MockAuthorListView: GitAuthorView {
    
    var alertMessage: String?
    func showAlert(message: String) {
        self.alertMessage = message
    }
    
    var stopTableRefreshCalled = false
    func stopTableRefresh() {
        stopTableRefreshCalled = true
    }
    
    var hideLoadingViewCalled = false
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    
    var reloadTableCalled = false
    func reloadTable() {
        reloadTableCalled = true
    }
}

