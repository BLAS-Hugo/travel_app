//
//  MockAPIClient.swift
//  voyageTests
//
//  Created by Hugo Blas on 21/06/2024.
//

import Foundation
@testable import voyage

struct MockAPIClient: APIClientProtocol {
    var urlSession: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
