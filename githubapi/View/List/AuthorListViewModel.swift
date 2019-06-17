//
//  AuthorListViewModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation
struct AuthorListViewModel {
    weak var delegate: GitAuthorView?
    var commitList: [GitAuthorDetails] = []
}

extension AuthorListViewModel: GitAuthorViewModel {
    var numberOfRows: Int {
        return 1//commitList.count
    }
    
    func authorInfo(at index: Int) -> AuthorInfo {
        let listItem = commitList[index]
        return AuthorInfo(listItem.authorName, listItem.sha, listItem.commitMessage)
    }
}
