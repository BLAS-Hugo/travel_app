//
//  ViewController.swift
//  voyage
//
//  Created by Hugo Blas on 06/06/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init {
            // try await CurrencyRepository().getExchangeRates()
            // try await TranslationRepository().translate(source: "Anglais")
            try await WeatherRepository().getWeather(city: City.nyc)
        }
    }


}

