//
//  WeatherRepository.swift
//  voyage
//
//  Created by Hugo Blas on 13/06/2024.
//

import Foundation

class WeatherRepository {
    private let apiKey = "eb3da9b517757867067c092eb645acde"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"

    var client: APIClientProtocol

    static var shared = WeatherRepository(client: BaseAPIClient())

    init(client: APIClientProtocol) {
        self.client = client
    }

    public func getWeather(city: City) async throws -> WeatherResponse {
        let url = URL(string: "\(baseURL)id=\(city.id)&appid=\(apiKey)")
        let request = URLRequest(url: url!)

        let (data, _) = try await client.urlSession.data(for: request)

        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return weather
    }
}

enum WeatherError: Error {
    case invalidCoords
}

enum City: String {
    case nyc = "New York City"
    case lille = "Lille"

    var id: String {
        switch self {
        case .nyc:
            "5128581"
        case .lille:
            "2998324"
        }
    }
}
