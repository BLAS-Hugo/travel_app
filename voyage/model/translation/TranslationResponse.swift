//
//  TranslationResponse.swift
//  voyage
//
//  Created by Hugo Blas on 12/06/2024.
//

import Foundation

class TranslationResponse: Codable {
    let data: Translations
}

class Translations: Codable {
    let translations: [Translation]
}

class Translation: Codable {
    let translatedText: String
    let detectedSourceLanguage: String
}
