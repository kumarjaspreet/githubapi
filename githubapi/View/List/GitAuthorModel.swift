//
//  GitAuthorModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

class GitContributions: Codable {
    var total: Int?
}

class GitAuthorDetails: Codable {
    var sha: String?
    var commit: GitCommit?
    var author: GitAuthor?
    
    var commitMessage: String? {
        return commit?.message
    }
    
    var authorName: String? {
        return author?.name
    }
}

class GitCommit: Codable {
    var message: String?
}

class GitAuthor: Codable {
    var name: String?
}
