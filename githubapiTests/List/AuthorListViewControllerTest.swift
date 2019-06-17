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
    var mockManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockManager = MockNetworkManager()
        mockViewModel = MockAuthorListViewModel(project: "project", repo: "repo", manager: mockManager)
        viewController = AuthorListViewController()
        viewController.viewModel = mockViewModel
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
        mockViewModel = nil
    }
    
    func testViewDidLoad() {
        let tableView = UITableView()
        let loadingView = UIView()
        viewController.tableView = tableView
        viewController.loadingView = loadingView
        viewController.viewDidLoad()
        XCTAssertTrue(mockViewModel.viewLoadedCalled)
        XCTAssertNotNil(tableView.refreshControl)
        XCTAssertFalse(loadingView.isHidden)
    }
    
    func testDefaultViewModel() {
        let vc = AuthorListViewController()
        XCTAssertNil(vc.viewModel)
    }
    
    func testViewModelInit() {
        let vc = AuthorListViewController()
        vc.updateProject(project: "project", repo: "repo")
        XCTAssertNotNil(vc.viewModel)
    }
    
    func testUpdateProject() {
        viewController.updateProject(project: "project", repo: "repo")
        XCTAssert(mockViewModel.projectName == "project")
        XCTAssert(mockViewModel.repoName == "repo")
        XCTAssertNotNil(mockViewModel.manager)
    }
    
    func testNumberOfRows() {
        let tableView = UITableView()
        viewController.tableView = tableView
        
        let rows = viewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssert(rows == 1)
    }
}

class MockAuthorListViewModel: GitAuthorViewModel {
    var projectName: String?
    var repoName: String?
    var manager: GitNetworkManager?
    required init(project: String, repo: String, manager: GitNetworkManager) {
        projectName = project
        repoName = repo
        self.manager = manager
    }
    
    var viewLoadedCalled = false
    func fetchList() {
        viewLoadedCalled = true
    }
    
    func authorInfo(at index: Int) -> AuthorInfo {
        return AuthorInfo("name", "sha", "commit message")
    }
    
    var delegate: GitAuthorView?
    
    var numberOfRows: Int {
        return 1
    }
    
    var index: Int?
    func tableScrolled(at index: Int) {
        self.index = index
    }
}

class MockNetworkManager: GitNetworkManager {
    init() {}
    
    var session:URLSessionProtocol?
    required init(session: URLSessionProtocol) {
        self.session = session
    }
    
    var repoUrl: String?
    func fetchList<T>(repoUrl: String, completion: @escaping (([T]) -> Void), failure: @escaping ServiceFailure) where T : Decodable, T : Encodable {
        self.repoUrl = repoUrl
    }
}
