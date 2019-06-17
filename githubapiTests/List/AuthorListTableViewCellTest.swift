//
//  AuthorListTableViewCellTest.swift
//  githubapiTests
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import XCTest
@testable import githubapi

class AuthorListTableViewCellTest: XCTestCase {
    
    var cell: AuthorTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = AuthorTableViewCell()
    }
    
    override func tearDown() {
        super.tearDown()
        cell = nil
    }
    
    func testConfigureCell() {
        let authorLabel = UILabel()
        let shaLabel = UILabel()
        let commitMsgLabel = UILabel()
        
        cell.authorNameLabel = authorLabel
        cell.commitHashLabel = shaLabel
        cell.commitMessageLabel = commitMsgLabel
        
        cell.configureCell(authorInfo: AuthorInfo("name", "xcafyrr", "commit message"))
        XCTAssert(authorLabel.text == "name")
        XCTAssert(shaLabel.text == "Commit: xcafyrr")
        XCTAssert(commitMsgLabel.text == "commit message")
    }
}
