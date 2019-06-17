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
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var repoNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: SeacrhGithubView {
    
}
