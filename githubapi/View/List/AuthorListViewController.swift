//
//  AuthorListViewController.swift
//  githubapi
//
//  Created by Jaspreet Kumar on 6/16/19.
//  Copyright © 2019 Jaspreet Kumar. All rights reserved.
//

import UIKit
class AuthorListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: GitAuthorViewModel = AuthorListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AuthorListViewController: GitAuthorView {
    
}

extension AuthorListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AuthorListConstants.cellIdentifier, for: indexPath) as! AuthorTableViewCell
        let authorInfo = viewModel.authorInfo(at: indexPath.row)
        cell.configureCell(authorInfo: authorInfo)
        return cell
    }
}

extension AuthorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
