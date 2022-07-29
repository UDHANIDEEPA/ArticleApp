//
//  GenericTableViewDataSource.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import UIKit

class GenericTableViewDataSource<Cell, Item>: NSObject, UITableViewDataSource, UITableViewDelegate where Cell: UITableViewCell {
   
    private var items: [Item]
    private let config: (Item, Cell) -> Void
    private let selectionHandler: (Item) -> Void
    private let cellIdentifier: String
    
    init(items: [Item], cellIdentifier:String, config: @escaping(Item, Cell) -> Void, selectionHandler: @escaping (Item) -> Void) {
        self.items = items
        self.config = config
        self.selectionHandler = selectionHandler
        self.cellIdentifier = cellIdentifier
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count > 0 ? items.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? Cell else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found")
        }
       config(items[indexPath.row], cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectionHandler(items[indexPath.row])
    }
        
}

extension GenericTableViewDataSource {
    func update(data items: [Item]) {
        DispatchQueue.main.sync {
            self.items = items
        }
    }
}

