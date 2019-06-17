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
    
    func testFetchList() {
        viewModel.currentPage = 3
        viewModel.fetchList()
        XCTAssert(mockManager.repoUrl == "project/repo/commits?per_page=25&page=1")
    }
    
    func testNumberOfRows() {
        viewModel.commitList = mockGitAuthorList
        let rows = viewModel.numberOfRows
        XCTAssert(rows == 2)
    }
    
    func testTableScrolledWhenCommitListIsComplete() {
        viewModel.isCommitListComplete = true
        viewModel.tableScrolled(at: 0)
        XCTAssertFalse(mockManager.fetchServiceCalled)
    }
    
    func testTableScrolledWhenIndexIsNotAtEnd() {
        viewModel.isCommitListComplete = false
        viewModel.commitList = mockGitAuthorList
        viewModel.tableScrolled(at: 0)
        XCTAssertFalse(mockManager.fetchServiceCalled)
    }
    
    func testTableScrolledIndexIsAtEnd() {
        viewModel.currentPage = 1
        viewModel.isCommitListComplete = false
        viewModel.commitList = mockGitAuthorList
        viewModel.tableScrolled(at: 1)
        XCTAssertTrue(mockManager.fetchServiceCalled)
        XCTAssert(viewModel.currentPage == 2)
    }
    
    func testCompletionBlockRefreshList() {
        viewModel.isRefreshList = true
        viewModel.currentPage = 2
        viewModel.commitList = mockGitAuthorList
        let completion = viewModel.completion
        completion(mockGitAuthorList)
        XCTAssertFalse(viewModel.isRefreshList)
        XCTAssertTrue(viewModel.isCommitListComplete)
        XCTAssertTrue(mockDelegate.hideLoadingViewCalled)
        XCTAssertTrue(mockDelegate.stopTableRefreshCalled)
        XCTAssertTrue(mockDelegate.reloadTableCalled)
        XCTAssert(viewModel.commitList.count == 2)
        XCTAssert(viewModel.currentPage == 1)
    }
    
    func testCompletionBlockUpdateList() {
        viewModel.isRefreshList = false
        viewModel.commitList = mockGitAuthorList
        let completion = viewModel.completion
        completion(mockGitAuthorList)
        XCTAssertFalse(viewModel.isRefreshList)
        XCTAssertTrue(viewModel.isCommitListComplete)
        XCTAssertTrue(mockDelegate.hideLoadingViewCalled)
        XCTAssertTrue(mockDelegate.stopTableRefreshCalled)
        XCTAssertTrue(mockDelegate.reloadTableCalled)
        XCTAssert(viewModel.commitList.count == 4)
    }
    
    func testResetList() {
        viewModel.commitList = mockGitAuthorList
        viewModel.currentPage = 3
        viewModel.resetList()
        XCTAssert(viewModel.currentPage == 1)
        XCTAssertTrue(viewModel.commitList.isEmpty)
    }
    
    func testFailureWhenFirstTimeFetch() {
        viewModel.currentPage = 1
        viewModel.isRefreshList = true
        let error = NSError(domain: "domain", code: 1, userInfo: nil)
        let failure = viewModel.failure
        failure(error)
        XCTAssertTrue(mockDelegate.stopTableRefreshCalled)
        XCTAssertTrue(mockDelegate.hideLoadingViewCalled)
        XCTAssertFalse(viewModel.isRefreshList)
        XCTAssert(mockDelegate.alertMessage == "Something went wrong! Please check project and repo name or try again later.")
    }
    
    func testFailureUpdate() {
        viewModel.currentPage = 2
        let error = NSError(domain: "domain", code: 1, userInfo: nil)
        let failure = viewModel.failure
        failure(error)
        XCTAssertTrue(mockDelegate.stopTableRefreshCalled)
        XCTAssertTrue(mockDelegate.hideLoadingViewCalled)
        XCTAssertNil(mockDelegate.alertMessage)
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

