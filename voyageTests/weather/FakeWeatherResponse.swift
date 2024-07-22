//
//  FakeWeatherResponse.swift
//  voyageTests
//
//  Created by Hugo Blas on 05/07/2024.
//

import Foundation

class FakeWeatherResponse {
    static let responseOk = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseError = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class WeatherError: Error {}
    static let error = WeatherError()

    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherResponse.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")

        return try! Data(contentsOf: url!)
    }

    static let weatherWrongData = "error".data(using: .utf8)!
}
