//
//  ArticleListTableViewController.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation
import UIKit

class ArticleListTableViewController: UITableViewController {
    
    private var articleListVM : ArticleListViewModel = ArticleListViewModel()
    
    private var tableDataSource: GenericTableViewDataSource<ArticleTableViewCell, ArticleViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func configureTableView(_ data: [ArticleViewModel]) {
        self.tableDataSource = GenericTableViewDataSource(items: data, cellIdentifier: "ArticleTableViewCell", config: { (item, cell) in
            //        cell.carVM = item
        }, selectionHandler: { (_) in
            print("Product")
        })
        self.tableView.dataSource = self.tableDataSource
        self.tableView.reloadData()
    }
    
    
    private func setup() {
        articleListVM.fetchArticleList(){ error in
            if error == nil {
                DispatchQueue.main.async {
                    self.configureTableView( self.articleListVM.getArticleList())
                }
            }
        }
    }
    
}
