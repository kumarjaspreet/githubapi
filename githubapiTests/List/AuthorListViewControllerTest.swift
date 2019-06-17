//
//  AuthorListViewControllerTest.swift
//  githubapiTests
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class AuthorListViewControllerTest: XCTestCase {
    
    var viewController: AuthorListViewController!
    var mockViewModel: MockAuthorListViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockAuthorListViewModel()
        viewController = AuthorListViewController()
        viewController.viewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
        mockViewModel = nil
    }
    
    func testNumberOfRows() {
        let tableView = UITableView()
        viewController.tableView = tableView
        
        let rows = viewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssert(rows == 1)
    }
}

class MockAuthorListViewModel: GitAuthorViewModel {
    
    func authorInfo(at index: Int) -> AuthorInfo {
        return AuthorInfo("name", "sha", "commit message")
    }
    
    var delegate: GitAuthorView?
    
    var numberOfRows: Int {
        return 1
    }
}
