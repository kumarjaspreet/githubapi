//
//  AuthorListWireframes.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

typealias AuthorInfo = (name: String?, commit: String?, message: String?)

protocol GitAuthorView: class {
    func reloadTable()
    func showAlert(message: String)
    func stopTableRefresh()
    func hideLoadingView()
}

protocol GitAuthorViewModel {
    var delegate: GitAuthorView? { get set }
    init(project: String, repo: String,  manager: GitNetworkManager)
    
    func fetchList()
    var numberOfRows: Int { get }
    func authorInfo(at index:Int) -> AuthorInfo
    func tableScrolled(at index: Int)
}

struct AuthorListConstants {
    static let cellIdentifier = "AuthorTableViewCell"
    static let errorMessage = "Something went wrong! Please check project and repo name or try again later."
}
