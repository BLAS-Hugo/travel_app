//
//  FakeCurrencyResponse.swift
//  voyageTests
//
//  Created by Hugo Blas on 20/06/2024.
//

import Foundation

class FakeCurrencyResponse {
    static let responseOk = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseError = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class CurrencyError: Error {}
    static let error = CurrencyError()

    static var currencyCorrectData: Data {
        let bundle = Bundle(for: FakeCurrencyResponse.self)
        let url = bundle.url(forResource: "ExchangeRates", withExtension: "json")

        return try! Data(contentsOf: url!)
    }

    static let currencyWrongData = "error".data(using: .utf8)!
}
