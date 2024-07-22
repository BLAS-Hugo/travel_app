//
//  TranslationViewController.swift
//  voyage
//
//  Created by Hugo Blas on 05/07/2024.
//

import Foundation
import UIKit
import NaturalLanguage

class TranslationViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var labelView: LabelView!
    var translatedString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTranslateButtonTapped() {
        if !textField.hasText {
            return
        }
        Task.init {
            await translate()
        }
    }
    
    func translate() async {
        let lang = NLLanguageRecognizer.dominantLanguage(for: textField.text!)
        do {
            let response = try await TranslationRepository.shared.translate(source: textField.text!)
            print(response.translatedText)
            translatedString = response.translatedText

            let label = UILabel()

            label.text = translatedString
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            labelView.addSubview(label)

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor)
            ])
        } catch {
            let alertController = UIAlertController(title: "Une erreur est survenue", message: "Veuillez vérifier votre connexion internet", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))

            present(alertController, animated: true)
        }
    }
}
