//
//  ArticleApi.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation

struct ArticleApi: APIRouteable {
    
    
    var path: String {
        "viewed/7.json?api-key=\(Environment.shared.articlesApiKey)"
    }
    
   // var parameters: Parameters?
   // var encoding: ParameterEncoding
    var method: HTTPMethod{
        .get
    }
    
    func parse (data: Data) throws -> APiResponse {
        do {
            let parsedData = try JSONDecoder().decode(APiResponse.self, from: data)
            return parsedData
        }
        catch {
            throw error
        }
    }
  
}
