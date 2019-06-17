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
    var isRefreshList = false
    
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
    
    func fetchList() {
        isRefreshList = true
        fetchCommitList(at: 1)
    }
    
    func tableScrolled(at index: Int) {
        guard !isCommitListComplete else { return }
        guard index+1 == commitList.count else { return }
        //TODO: Below code can be optimized by using UITableViewDataSourcePrefetching
        currentPage += 1
        fetchCommitList(at: currentPage)
    }
    
    func resetList() {
        currentPage = 1
        commitList = []
    }
    
    private func fetchCommitList(at index: Int) {
        //TODO: Below code can be refactored to use URLComponents.
        let commitUrl = "\(NetworkConstants.perPageUrl)=\(NetworkConstants.commitsPerPage)"
        let pageUrl = "\(NetworkConstants.currentpageUrl)=\(index)"
        let url = "\(projectName)/\(repoName)/commits?\(commitUrl)&\(pageUrl)"
        networkManager.fetchList(repoUrl: url, completion: completion, failure: failure)
    }
    
    var completion: ServiceCompletion<GitAuthorDetails> {
        return {[weak self] list in
            print("**************************LIST LOADED >>>>>>>>>\(self!.currentPage)************************")
            self?.updateCommitList(list)
        }
    }
    
    var failure: ServiceFailure {
        return { [weak self] _ in
            defer {
                self?.isRefreshList = false
                self?.delegate?.hideLoadingView()
                self?.delegate?.stopTableRefresh()
            }
            guard self?.currentPage == 1 else { return }
            self?.delegate?.showAlert(message: AuthorListConstants.errorMessage)
        }
    }
    
    func updateCommitList(_ list: [GitAuthorDetails]) {
        defer {
            isRefreshList = false
            isCommitListComplete = list.count < NetworkConstants.commitsPerPage
            delegate?.hideLoadingView()
            delegate?.stopTableRefresh()
        }
        guard list.count > 0 else { return }
        if isRefreshList {
            commitList = list
            currentPage = 1
        } else {
            commitList += list
        }
        delegate?.reloadTable()
    }
}
