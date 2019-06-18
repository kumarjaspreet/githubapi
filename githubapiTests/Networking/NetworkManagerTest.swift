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
    
    //More unit tests can be written covering all scenarios
    func testFetchList() {
        manager.fetchList(repoUrl: "commit", completion: completion, failure: failure)
        XCTAssertNotNil(mockDataTask)
        XCTAssert(mockSession.url == "https://api.github.com/repos/commit")
        XCTAssertTrue(mockDataTask.resumeCalled)
    }
    
    func testNetworkResponseCompletionHandlerError() {
        let networkCompletion = manager.networkResponseCompletionHandler(completion: completion, failure: failure)
        let error = NSError(domain: "domain", code: 1, userInfo: nil)
        networkCompletion(nil, nil, error)
        XCTAssertTrue(failureCalled)
    }
    
    func testNetworkResponseCompletionHandlerDecodeError() {
        let networkCompletion = manager.networkResponseCompletionHandler(completion: completion, failure: failure)
        networkCompletion(invalidModelData, nil, nil)
        XCTAssertTrue(failureCalled)
    }
    
    func testNetworkResponseCompletionDefaultError() {
        let networkCompletion = manager.networkResponseCompletionHandler(completion: completion, failure: failure)
        networkCompletion(nil, nil, nil)
        XCTAssertTrue(failureCalled)
    }
    
    func testNetworkResponseCompletionHandlerSuccess() {
        let networkCompletion = manager.networkResponseCompletionHandler(completion: completion, failure: failure)
        networkCompletion(validModelData, nil, nil)
        XCTAssertTrue(completionCalled)
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
    
    private var invalidModelData: Data {
        let object = ["test":["object":"any"]]
        let data = try! JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        return data
    }
    
    private var validModelData: Data {
        let object = [["test":"1"], ["test":"2"], ["test":"3"]]
        let data = try! JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        return data
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
