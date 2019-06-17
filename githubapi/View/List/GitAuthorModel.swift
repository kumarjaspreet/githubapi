//
//  GitAuthorModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

struct GitContributions: Codable {
    var total: Int?
}

struct GitAuthorDetails: Codable {
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

struct GitCommit: Codable {
    var message: String?
}

struct GitAuthor: Codable {
    var name: String?
}
