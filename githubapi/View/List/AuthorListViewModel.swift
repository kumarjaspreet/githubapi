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
}

extension AuthorListViewModel: GitAuthorViewModel {
    
}
