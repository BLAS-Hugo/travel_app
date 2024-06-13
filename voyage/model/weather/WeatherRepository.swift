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

    public func getWeather(lat: String, lon: String) async throws -> WeatherResponse {
        let url = URL(string: "\(baseURL)lat=\(lat)&lon=\(lon)&exclude=hourly,minutely,daily,alerts&appid=\(apiKey)")

        let request = URLRequest(url: url!)

        let (data, _) = try await URLSession.shared.data(for: request)

        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return weather
    }
}
