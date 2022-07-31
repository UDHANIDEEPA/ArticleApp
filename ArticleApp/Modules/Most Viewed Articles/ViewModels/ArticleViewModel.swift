//
//  ArticleViewModel.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation
import Alamofire

class ArticleListViewModel {
    private(set) var articles: [ArticleViewModel] = []
}

extension ArticleListViewModel {
    func fetchArticleList(completion: @escaping (Result<Bool, NYError>) -> Void) {
        let request = ArticleApi()
        ApiTask().request(request) {[weak self]  result in
            switch result {
            case .success(let data):
                print(data)
                do {
                    let parsedData = try request.parse(data: data)
                    self?.articles = parsedData.results.map {ArticleViewModel($0)}
                    completion(.success(true))
                    return
                }
                catch {
                    completion(.failure(.parsing))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}

extension ArticleListViewModel {
    
    func getArticleList()  -> [ArticleViewModel]{
        return self.articles
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        return self.articles[index]
    }
    
}

struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: String {
        return self.article.title
    }
    
    var author: String {
        return self.article.byline
    }
    
    var publishDate: String {
        return self.article.publishedDate
    }
    
    var description: String {
        return self.article.abstract
    }
    
    var updatedDate: String {
        return self.article.updated
    }
    
    var thumbnailImageUrl: String {
        if self.article.media.count > 0 {
            let media = self.article.media[0]
            if media.mediaMetadata.count > 0 {
                return media.mediaMetadata[0].url
            }
        }
        return ""
    }
    
    
    var descriptionImageUrl: String {
        if self.article.media.count > 0 {
            let media = self.article.media[0]
            if media.mediaMetadata.count > 0 {
                return media.mediaMetadata[2].url
            }
        }
        return ""
    }
    
}
