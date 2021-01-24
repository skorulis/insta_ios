//
//  Endpoints.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import Foundation


struct Endpoints {
    
    static func search(query: String) -> JSONAPIRequest<EmptyRequestModel, [InstaUser]> {
        let queryParam = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let path = "search?username=\(queryParam)"
        return JSONAPIRequest(path: path, body: EmptyRequestModel())
    }
    
}
