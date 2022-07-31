//
//  ArticleListTableViewController.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation
import UIKit

class ArticleListViewController: UIViewController {
    @IBOutlet weak var articleTableView: UITableView!
    
    private var articleListVM : ArticleListViewModel = ArticleListViewModel()
    private var tableDataSource: GenericTableViewDataSource<ArticleTableViewCell, ArticleViewModel>!

    // MARK: View Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Other required private methods
    
    private func configureTableView(_ data: [ArticleViewModel]) {
        self.tableDataSource = GenericTableViewDataSource(items: data, cellIdentifier: "ArticleTableViewCell", config: { (item, cell) in
            cell.selectionStyle = .none
            cell.articleVM = item
        }, selectionHandler: { (_) in
            print("Product")
        })
        self.articleTableView.dataSource = self.tableDataSource
        self.articleTableView.delegate = self
        self.articleTableView.reloadData()
    }
    
    
    private func setup() {
        articleListVM.fetchArticleList(){ [weak self]  result in
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    self?.configureTableView( self?.articleListVM.getArticleList() ?? [])
                }
            case .failure(let error):
                self?.handleError(error)
            }

        }
    }
    
    private func handleError(_ error: Error) {
        self.showDefaultAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK", actionBlock: nil, cancelActionTitle: nil, cancelActionBlock: nil)
    }
    
}

extension ArticleListViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let selectedItem = self.articleListVM.getArticleList()[indexPath.row]
        self.performSegue(withIdentifier: "ArticleDetailsViewController", sender: selectedItem)
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}


extension ArticleListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.SeguesNames.articleDetailsViewController {
            if let articleDetailsViewController = segue.destination as? ArticleDetailsViewController {
                articleDetailsViewController.selectedArticle = sender as? ArticleViewModel
            }
        }
    }
}
