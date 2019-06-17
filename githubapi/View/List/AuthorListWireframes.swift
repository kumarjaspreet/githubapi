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
    
}

protocol GitAuthorViewModel {
    var delegate: GitAuthorView? { get set }
    var numberOfRows: Int { get }
    func authorInfo(at index:Int) -> AuthorInfo
}

struct AuthorListConstants {
    static let cellIdentifier = "AuthorTableViewCell"
}
