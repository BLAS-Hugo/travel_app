//
//  WeatherResponse.swift
//  voyage
//
//  Created by Hugo Blas on 13/06/2024.
//

import Foundation

class WeatherResponse: Codable {
    let weather: [Weather]
    let main: Temperature
}

class Weather: Codable {
    let main: String
    let description: String
}

class Temperature: Codable {
    let temp: Double
}
