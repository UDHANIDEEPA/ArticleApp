//
//  Constants.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation


struct K {
    struct URLs {
        static let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/"
        static let mostViewedArticle = "viewed/7.json?api-key=\(Environment.shared.articlesApiKey)"
    }
    
    struct CellIdentifiers {
        static let articleTableViewCell = "ArticleTableViewCell"
    }
    
    struct NibNames {
        static let articleListViewController = "ArticleListViewController"
    }
    struct SeguesNames {
        static let articleDetailsViewController = "ArticleDetailsViewController"
    }
}
