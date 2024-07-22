//
//  TranslationRepository.swift
//  voyage
//
//  Created by Hugo Blas on 11/06/2024.
//

import Foundation

class TranslationRepository {
    var client: APIClientProtocol

    static var shared = TranslationRepository(client: BaseAPIClient())

    init(client: APIClientProtocol) {
        self.client = client
    }

    private let baseUrl: String = "https://translation.googleapis.com/language/translate/v2"
    private let apiKey: String = "AIzaSyB4e9UBWTbn9jjnaIS3z-xUJ9aTQ26pbyc"

    public func translate(source: String) async throws -> Translation {
        let url = URL(string: "\(baseUrl)?key=\(apiKey)&q=\(source)&target=en")

        let request = URLRequest(url: url!)

        let (data, _) = try await client.urlSession.data(for: request)

        let translate = try JSONDecoder().decode(TranslationResponse.self, from: data)

        return translate.data.translations.first!
    }
}
