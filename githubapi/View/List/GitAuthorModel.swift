//
//  GitAuthorModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

struct GitAuthorDetails: Codable {
    var sha: String?
    var commit: GitCommit?
    
    var commitMessage: String? {
        return commit?.message
    }
    
    var authorName: String? {
        return commit?.author?.name
    }
}

struct GitCommit: Codable {
    var message: String?
    var author: GitAuthor?
}

struct GitAuthor: Codable {
    var name: String?
}
