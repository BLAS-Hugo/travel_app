//
//  WeatherViewController.swift
//  voyage
//
//  Created by Hugo Blas on 05/07/2024.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    private var weather: WeatherResponse?

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init {
            await getWeather()
        }
    }

    private func getWeather() async{
        let weatherRepository = WeatherRepository.shared

        do {
            weather = try await weatherRepository.getWeather(city: City.nyc)

            print(weather?.weather.first?.description)
            mainLabel.text = weather?.weather.first?.main
            descriptionLabel.text = weather?.weather.first?.description
            descriptionLabel.numberOfLines = 5
            tempLabel.text = String(format: "%.1f", weather?.main.temp ?? 0)
        } catch {
            let alertController = UIAlertController(title: "Une erreur est survenue", message: "Veuillez vérifier votre connexion internet", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))

            present(alertController, animated: true)
        }
    }
}
