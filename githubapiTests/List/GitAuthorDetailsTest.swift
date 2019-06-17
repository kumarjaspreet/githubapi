//
//  GitAuthorDetailsTest.swift
//  githubapiTests
//
//  Created by Pooja on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class GitAuthorDetailsTest: XCTestCase {
    
    func testModel() {
        let gitAuthor = mockGitAuthorList.first!
        XCTAssert(gitAuthor.authorName == "author")
        XCTAssert(gitAuthor.commitMessage == "message")
    }
}

var mockGitAuthorList: [GitAuthorDetails] {
    let commit1 = GitCommit(message: "message", author: GitAuthor(name: "author"))
    let gitAuthor1 = GitAuthorDetails(sha: "sha", commit: commit1)
    
    let commit2 = GitCommit(message: "message2", author: GitAuthor(name: "author2"))
    let gitAuthor2 = GitAuthorDetails(sha: "sha2", commit: commit2)
    
    return [gitAuthor1, gitAuthor2]
}
