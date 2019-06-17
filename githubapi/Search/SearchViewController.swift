//
//  SearchViewController.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import UIKit

protocol SeacrhGithubView: class {
    
}

class SearchViewController: UIViewController {
    var viewModel: GithubSearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension SearchViewController: SeacrhGithubView {
    
}
