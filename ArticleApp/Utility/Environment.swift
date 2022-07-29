//
//  Environment.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation


struct Environment {
    
    static let shared = Environment()

    var articlesApiKey: String {
        return
        Bundle.main.object(forInfoDictionaryKey: "ARTICLES_MOSTVIEWED_API_KEY") as? String ?? ""
    }

}
