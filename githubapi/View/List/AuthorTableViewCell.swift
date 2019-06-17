//
//  AuthorTableViewCell.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/17/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import UIKit
class AuthorTableViewCell: UITableViewCell {
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var commitHashLabel: UILabel!
    @IBOutlet weak var commitMessageLabel: UILabel!
    
    func configureCell(authorInfo: AuthorInfo) {
        authorNameLabel.text = authorInfo.name
        commitHashLabel.text = authorInfo.commit
        commitMessageLabel.text = authorInfo.message
    }
}
