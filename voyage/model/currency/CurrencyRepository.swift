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
        let url = URL(string: "\(baseUrl)latest?access_key=\(apiKey)")

        let request = URLRequest(url: url!)

        let (data, _) = try await URLSession.shared.data(for: request)

        let rates = try JSONDecoder().decode(RatesResponse.self, from: data)

        writeToFile(rates: rates)

        readRatesFromCache()

        return rates
    }

    private func writeToFile(rates: RatesResponse) {
        if let json = try? JSONEncoder().encode(rates) {
            let url = URL.documentsDirectory.appending(path: "rates.json")

            if FileManager.default.fileExists(atPath: url.path) {
                try? FileManager.default.removeItem(at: url)
            }

            FileManager.default.createFile(atPath: url.path, contents: json)
        }
    }

    private func readRatesFromCache() {
        let url = URL.documentsDirectory.appending(path: "rates.json")

        do {
            let data = try Data(contentsOf: url)

            let rates = try JSONDecoder().decode(RatesResponse.self, from: data)

            print(rates.rates)
        } catch {
            print("error")
        }
    }
}
