//
//  NetworkManagerTest.swift
//  githubapiTests
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class NetworkManagerTest: XCTestCase {
    
    var manager: NetworkManager!
    var mockDataTask: MockURLSesseionDataTask!
    var mockSession: MockURLSession!
    var completionCalled = false
    var failureCalled = false
    
    override func setUp() {
        super.setUp()
        mockDataTask = MockURLSesseionDataTask()
        mockSession = MockURLSession(dataTask: mockDataTask)
        manager = NetworkManager(session: mockSession)
    }
    
    override func tearDown() {
        super.tearDown()
        manager = nil
    }
    
    func testFetchList() {
        manager.fetchList(repoUrl: "commit", completion: completion, failure: failure)
        XCTAssertNotNil(mockDataTask)
        XCTAssert(mockSession.url == "https://api.github.com/repos/commit")
        XCTAssertTrue(mockDataTask.resumeCalled)
    }
    
    //Below code can be made more testable in future
    var completion: ServiceCompletion<MockGitModel> {
        return {[weak self] _ in
            self?.completionCalled = true
        }
    }
    
    var failure: ServiceFailure {
        return {[weak self] _ in
            self?.failureCalled = true
        }
    }
}

struct MockGitModel: Codable {
    var test: String?
}

class MockURLSesseionDataTask: URLSessionDataTaskProtocol {
    
    var cancelCalled = false
    func cancel() {
        cancelCalled = true
    }
    
    var resumeCalled = false
    func resume() {
        resumeCalled = true
    }
    
    
}

class MockURLSession: URLSessionProtocol {
    
    let dataTask: URLSessionDataTaskProtocol
    init(dataTask: URLSessionDataTaskProtocol) {
        self.dataTask = dataTask
    }
    
    var url: String?
    func loadData(with request: URLRequest, completionHandler: @escaping NetworkDataResult) -> URLSessionDataTaskProtocol {
        url = request.url?.absoluteString
        return dataTask
    }
}
