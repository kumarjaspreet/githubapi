//
//  NetworkManager.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation
typealias NetworkDataResult = (Data?, URLResponse?, Error?) -> Void
typealias ServiceCompletion<T> = (([T]) -> Void)
typealias ServiceFailure = ((Error) -> Void)

protocol URLSessionDataTaskProtocol {
    func cancel()
    func resume()
}

protocol URLSessionProtocol {
    func loadData(with request: URLRequest, completionHandler: @escaping NetworkDataResult) -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
extension URLSession: URLSessionProtocol {
    func loadData(with request: URLRequest, completionHandler: @escaping NetworkDataResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

protocol GitNetworkManager {
    init(session: URLSessionProtocol)
    func fetchList<T: Codable>(repoUrl: String, completion: @escaping ServiceCompletion<T>, failure: @escaping ServiceFailure)
}

class NetworkManager: GitNetworkManager {
    private let session: URLSessionProtocol
    var dataTask: URLSessionDataTaskProtocol?
    
    required init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchList<T: Codable>(repoUrl: String, completion: @escaping ServiceCompletion<T>, failure: @escaping ServiceFailure)  {
        let urlString = NetworkConstants.baseUrl + repoUrl
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        let completionHandler = networkResponseCompletionHandler(completion: completion, failure: failure)
        dataTask = session.loadData(with: urlRequest, completionHandler: completionHandler)
        dataTask?.resume()
    }
    
    func networkResponseCompletionHandler<T: Codable>(completion: @escaping ServiceCompletion<T>, failure: @escaping ServiceFailure) -> NetworkDataResult {
        return {[weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                failure(error)
            } else if let data = data {
                strongSelf.parseSuccessData(data, completion: completion, failure: failure)
            } else {
                failure(strongSelf.defaultError)
            }
        }
    }
    
    func parseSuccessData<T: Codable>(_ data: Data, completion: ServiceCompletion<T>, failure: ServiceFailure) {
        do {
            let decoder = JSONDecoder()
            let list = try decoder.decode([T].self, from: data)
            completion(list)
        }
        catch let error {
            failure(error)
        }
    }
    
    var defaultError: Error {
        return NSError(domain: "Error while fetching commit list", code: 999, userInfo: nil)
    }
}
