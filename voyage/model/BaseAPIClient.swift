//
//  BaseAPIClient.swift
//  voyage
//
//  Created by Hugo Blas on 21/06/2024.
//

import Foundation

struct BaseAPIClient: APIClientProtocol {
    var urlSession: URLSession {
        return URLSession(configuration: .default)
    }
}
