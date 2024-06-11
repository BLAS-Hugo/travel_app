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
            let rates = try await CurrencyRepository().getExchangeRates()
        }
    }


}

