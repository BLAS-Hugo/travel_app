//
//  RatesResponse.swift
//  voyage
//
//  Created by Hugo Blas on 07/06/2024.
//

import Foundation

class RatesResponse: Codable {
    let base: String
    let rates: [String: Double]
    let date: String
}
