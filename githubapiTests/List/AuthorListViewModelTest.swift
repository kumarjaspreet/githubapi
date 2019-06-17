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
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockAuthorListView()
        viewModel = AuthorListViewModel()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockDelegate = nil
    }
}

class MockAuthorListView: GitAuthorView {
    
}

