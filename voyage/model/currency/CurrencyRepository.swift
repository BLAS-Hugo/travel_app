//
//  CurrencyRepository.swift
//  voyage
//
//  Created by Hugo Blas on 06/06/2024.
//

import Foundation

class CurrencyRepository {
    private let baseUrl: String = "http://data.fixer.io/api/"
    private let apiKey: String = "b798a571e8bc935167eafe2edf2b0bc2"

    public func getExchangeRates() async throws -> RatesResponse {
        let rates: RatesResponse

        do {
            rates = try await fetchExchangeRates()
        } catch {
            print("error")
            throw CurrencyFetchingError.networkError
        }


        return rates
    }

    private func fetchExchangeRates() async throws -> RatesResponse {
        let url = URL(string: "\(baseUrl)latest?access_key=\(apiKey)")

        let request = URLRequest(url: url!)

        let (data, response) = try await URLSession.shared.data(for: request)

        let rates = try JSONDecoder().decode(RatesResponse.self, from: data)

        return rates
    }
}

enum CurrencyFetchingError: Error {
case networkError
}
