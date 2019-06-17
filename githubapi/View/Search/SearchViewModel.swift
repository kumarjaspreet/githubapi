//
//  SearchViewModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

struct SearchViewModel {
    weak var delegate: SeacrhGithubView?
}

extension SearchViewModel: GithubSearchViewModel {
    func searchButtonClicked(projectName: String?, repoName: String?) {
        guard projectName?.isEmpty == false, repoName?.isEmpty == false else {
            delegate?.showAlert(message: SearchViewConstants.invalidEntryMessage)
            return
        }
        delegate?.showCommitList()
    }
}
