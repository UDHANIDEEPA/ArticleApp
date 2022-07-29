//
//  NYErrors.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation

enum NYError: Error {
    case unknown
    case parsing
    case business(message: String)
    case emptyResults
    
    case internet
    case connection
    case timedout
    
    case authentication
    
    case notModified
    
    case server
    
    //Parsing, Encoding
    case parsingResponse(message:String)
    
    //other
    case badRequest(message:String)
    case underlying(code:Int, message: String)
    case http(code:Int)
    case database(message: String)
}

extension NSError {
    var toNYError: NYError {
        
        let code =  URLError.Code(rawValue: self.code)
        
        switch code {
        case .notConnectedToInternet:
            return .internet
        case .timedOut:
            return .timedout
        case .networkConnectionLost:
            return .connection
        case .cannotConnectToHost:
            return .server
        case .userAuthenticationRequired:
            return .authentication
        case .badServerResponse, .cannotParseResponse, .cannotDecodeRawData, .cannotDecodeContentData:
            return .parsingResponse(message: "\(code): \(localizedDescription)")
        case .badURL, .unsupportedURL:
            return .badRequest(message: "\(code): Endpoint failed to encode the parameters for the URLRequest: \(localizedDescription)")
        default:
            return .underlying(code: code.rawValue, message: "\(code): \(localizedDescription)")
        }
        
    }
}
