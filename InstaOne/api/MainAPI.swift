//
//  MainAPI.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import ASNetworking
import Foundation
import Combine

protocol APIRequest {
    associatedtype ResponseType: Decodable
    
    var path: String { get }
    var method: String { get }
    var bodyData: Data? { get }
    
}

struct EmptyRequestModel: Encodable {}
struct EmptyResponseModel: Decodable {}

struct JSONAPIRequest<RequestType, ResponseType>: APIRequest where ResponseType: Decodable, RequestType: Encodable {
    var path: String
    var method: String = "GET"
    var body: RequestType
    
    init(path: String, body: RequestType) {
        self.path = path
        self.body = body
    }
    
    var bodyData: Data? {
        if body is EmptyRequestModel {
            return nil
        }
        return try? JSONEncoder().encode(body)
    }
    
}

class MainAPI: NetworkClient {
 
    private var baseURL = "http://localhost:5005"
    
    private func resolveURL<T: APIRequest>(_ request: T) -> URL {
        let urlString = "\(baseURL)/\(request.path)"
        guard let url = URL(string: urlString) else  {
            fatalError("Invalid url: \(urlString)")
        }
        return url
    }
    
    private func makeURLRequest<T: APIRequest>(_ request: T) -> URLRequest {
        let url = resolveURL(request);
        var req = URLRequest(url: url)
        req.httpMethod = request.method
        
        return req
    }
    
    func execute<T: APIRequest>(_ request: T) -> Future<T.ResponseType, Error> {
        let req = makeURLRequest(request)
        return self.execute(request: req)
    }
    
}
