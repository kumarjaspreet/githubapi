//
//  AuthorListViewModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation
class AuthorListViewModel {
    weak var delegate: GitAuthorView?
    var commitList: [GitAuthorDetails] = []
    var isCommitListComplete = false
    var currentPage = 1
    let networkManager: GitNetworkManager
    let projectName: String
    let repoName: String
    
    required init(project: String, repo: String,  manager: GitNetworkManager = NetworkManager()) {
        projectName = project
        repoName = repo
        networkManager = manager
    }
}

extension AuthorListViewModel: GitAuthorViewModel {
    var numberOfRows: Int {
        return commitList.count
    }
    
    func authorInfo(at index: Int) -> AuthorInfo {
        let listItem = commitList[index]
        return AuthorInfo(listItem.authorName, listItem.sha, listItem.commitMessage)
    }
    
    func viewLoaded() {
        //TODO: Below code can be refactored to use URLComponents. Due to time issues, I am using straight url
        let commitUrl = "\(NetworkConstants.perPageUrl)=\(NetworkConstants.commitsPerPage)"
        let pageUrl = "\(NetworkConstants.currentpageUrl)=\(currentPage)"
        let url = "\(projectName)/\(repoName)/commits?\(commitUrl)&\(pageUrl)"
        networkManager.fetchList(repoUrl: url, completion: completion, failure: failure)
    }
    
    func tableScrolled(at index: Int) {
        
    }
    
    func resetList() {
        currentPage = 1
        commitList = []
    }
    
    var completion: ServiceCompletion<GitAuthorDetails> {
        return {[weak self] list in
            print(list)
            self?.updateCommitList(list)
        }
    }
    
    var failure: ServiceFailure {
        return { _ in
        }
    }
    
    func updateCommitList(_ list: [GitAuthorDetails]) {
        if list.count > 0 {
            commitList += list
            delegate?.reloadTable()
        }
        isCommitListComplete = list.count < NetworkConstants.commitsPerPage
    }
}
