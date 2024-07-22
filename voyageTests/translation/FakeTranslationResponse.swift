//
//  FakeWeatherResponse.swift
//  voyageTests
//
//  Created by Hugo Blas on 05/07/2024.
//

import Foundation

class FakeTranslationResponse {
    static let responseOk = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseError = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class TranslationError: Error {}
    static let error = TranslationError()

    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeTranslationResponse.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")

        return try! Data(contentsOf: url!)
    }

    static let translationWrongData = "error".data(using: .utf8)!
}

