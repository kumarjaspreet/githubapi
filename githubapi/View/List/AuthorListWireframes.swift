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
}

protocol GitAuthorViewModel {
    var delegate: GitAuthorView? { get set }
    func viewLoaded()
    var numberOfRows: Int { get }
    func authorInfo(at index:Int) -> AuthorInfo
    init(project: String, repo: String,  manager: GitNetworkManager)
}

struct AuthorListConstants {
    static let cellIdentifier = "AuthorTableViewCell"
}
