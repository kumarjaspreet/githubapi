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
    var viewModel: GitAuthorViewModel!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        loadingView.isHidden = false
        view.bringSubviewToFront(loadingView)
        viewModel.fetchList()
    }
    
    @objc func refreshList() {
        viewModel.fetchList()
    }
    
    func updateProject(project: String, repo: String) {
        viewModel = AuthorListViewModel(project: project, repo: repo)
        viewModel.delegate = self
    }
}

extension AuthorListViewController: GitAuthorView {
    func showAlert(message: String) {
        DispatchQueue.main.async {[weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
            self?.loadingView.isHidden = true
        }
    }
    
    func stopTableRefresh() {
        DispatchQueue.main.async {[weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {[weak self] in
            self?.loadingView.isHidden = true
        }
    }
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.tableScrolled(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
