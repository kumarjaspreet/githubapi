//
//  SearchViewModel.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import Foundation

protocol GithubSearchViewModel {
    var delegate: SeacrhGithubView? { get set }
}

struct SearchViewModel {
    weak var delegate: SeacrhGithubView?
}

extension SearchViewModel: GithubSearchViewModel {
    
}
