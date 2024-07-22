//
//  ExchangeViewController.swift
//  voyage
//
//  Created by Hugo Blas on 21/06/2024.
//

import UIKit

class ExchangeViewController: UIViewController {
    @IBOutlet weak var labelView: LabelView!
    @IBOutlet weak var textField: UITextField!

    private var currentRate: Double = 0
    var amountToDisplay: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.keyboardType = UIKeyboardType.decimalPad

        Task.init {
            try? await getRatesFromServer()
            print(currentRate)
        }
    }

    private func getRatesFromServer() async throws {
        let currencyRepository = CurrencyRepository.shared
        do {
            let rates = try await currencyRepository.getExchangeRates()
            let rate = rates.rates
            currentRate = rate["USD"] ?? 0
        } catch {
            let alertController = UIAlertController(title: "Une erreur est survenue", message: "Veuillez vérifier votre connexion internet", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))

            present(alertController, animated: true)
        }
    }

    @IBAction func onConvertButtonTapped() {
        if !textField.hasText {
            return
        }
        let amount = Double(textField.text ?? "0")

        amountToDisplay = (amount ?? 0) * currentRate

        let label = UILabel()

        label.text = String(format: "%.2f", amountToDisplay ?? 0)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        labelView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor)
        ])
    }
}
