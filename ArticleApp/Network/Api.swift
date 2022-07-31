//
//  Api.swift
//  ArticleApp
//
//  Created by Vanshika on 29/07/2022.
//

import Foundation
import Alamofire

public protocol APIRouteable: URLRequestConvertible {
    //    associatedtype T
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    //var parameters: Parameters? { get }
    // var encoding: ParameterEncoding { get }
    
    //func parse (data: Data) throws -> T
}

extension APIRouteable {
    var baseURL: String { return K.URLs.baseURL }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        //let url = try baseURL.asURL().appendingPathComponent(path)
        let url = URL(string: baseURL)
        
        if let urlWithPath = (url.flatMap { URL(string: $0.absoluteString + path) }) {
           
            var urlRequest = URLRequest(url: urlWithPath)
            urlRequest.httpMethod = method.rawValue
            // return try encoding.encode(urlRequest, with: parameters)
            return urlRequest
        }
        
        return URLRequest(url: url!)

    }
    
}

public enum ApiError: Int, Error {
    case recieveNilResponse = 0,
         recieveErrorHttpStatus,
         recieveNilBody,
         failedParse,
         domainError
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//protocol ApiProtocol {
//
//    func request(_ apiRoute: APIRouteable, completion: @escaping (Result<Response, ApiError>) -> Void)
//}

open class ApiTask {
    
    //    public var httpHeader: [String: String]? = ["content-type": "application/json"]
    //    public var timeoutInterval: TimeInterval = 60
    //    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    //    static let apiTaskSession: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    public init() {}
    
    func request(_ apiRoute: APIRouteable, completion: @escaping (Result<Data, NYError>) -> Void){
        do {
            try AF.request(apiRoute.asURLRequest()).validate(statusCode: 200..<300).responseJSON { response in
                
                DispatchQueue.main.async {
                    if let status = response.response?.statusCode, status == 401 {
                        completion(Result.failure(NYError.authentication))
                        return
                    }
                    if let err = (response.error as NSError?)?.toNYError {
                        completion(Result.failure(err))
                        return
                    }
                    guard let data = response.data else {
                        return
                    }
                    
                    completion(.success(data))
                    return
                }
            }
        }
        catch {
            completion(.failure(NYError.badRequest(message: "Bad Request")))
            return
        }
        
    }
}



