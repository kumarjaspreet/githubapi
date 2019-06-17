//
//  SearchWireframes.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

protocol SeacrhGithubView: class {
    func showAlert(message: String)
    func showCommitList()
}

protocol GithubSearchViewModel {
    var delegate: SeacrhGithubView? { get set }
    func searchButtonClicked(projectName: String?, repoName: String?)
}

struct SearchViewConstants {
    static let invalidEntryMessage = "Project or repo name cannot be blank."
    static let listControllerIdentifier = "AuthorListViewController"
}
