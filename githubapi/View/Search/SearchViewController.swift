//
//  SearchViewController.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    var viewModel: GithubSearchViewModel = SearchViewModel()
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var repoNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        viewModel.searchButtonClicked(projectName: projectNameTextField.text, repoName: repoNameTextField.text)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: SeacrhGithubView {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCommitList(project: String, repo: String) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: SearchViewConstants.listControllerIdentifier) as? AuthorListViewController else { return }
        viewController.updateProject(project: project, repo: repo)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
