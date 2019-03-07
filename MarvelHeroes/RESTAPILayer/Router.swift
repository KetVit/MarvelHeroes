//
//  Router.swift
//  MarvelHeroes
//
//  Created by vit on 2/12/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case getHeroes(withLimit: Int, withOffset: Int)
    case getComics(withLimit: Int, withOffset: Int)
    case getCreators(withLimit: Int, withOffset: Int)

    static let baseURLString = "https://gateway.marvel.com"
    
    // define HTTP method
    var method: HTTPMethod {
        switch self {
        case .getHeroes, .getComics, .getCreators:
            return .get
        }
    }
    
    // assembled web link
    var path: String {
        switch self {
        case .getHeroes(let limit, let offset):
            return "/v1/public/characters?limit=\(limit)&offset=\(offset)&ts=1&apikey=7fcabde7c43d136312c02ddd457b5585&hash=59d26685428cdfe4e89e35ca8e90038a"
        case .getComics(let limit, let offset):
            return "/v1/public/comics?limit=\(limit)&offset=\(offset)&ts=1&apikey=7fcabde7c43d136312c02ddd457b5585&hash=59d26685428cdfe4e89e35ca8e90038a"
        case .getCreators(let limit, let offset):
            return "/v1/public/creators?limit=\(limit)&offset=\(offset)&ts=1&apikey=7fcabde7c43d136312c02ddd457b5585&hash=59d26685428cdfe4e89e35ca8e90038a"
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try (Router.baseURLString + path).asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        print("Вот это ссылка", urlRequest)
        return urlRequest
    }
}


