//
//  TranslationRepositoryTestCase.swift
//  voyageTests
//
//  Created by Hugo Blas on 05/07/2024.
//

import XCTest
@testable import voyage

final class TranslationRepositoryTestCase: XCTestCase {
    func test_success() async {
        let data = FakeTranslationResponse.translationCorrectData

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = FakeTranslationResponse.responseOk
            return (response, data)
        }

        let translationRepository = TranslationRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should succeed")
        let failureExpectation = expectation(description: "should not fail")
        failureExpectation.isInverted = true

        do {
            let _ = try await translationRepository.translate(source: "Anglais")
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_failure() async {
        let data = FakeTranslationResponse.translationCorrectData

        MockURLProtocol.error = FakeTranslationResponse.error
        MockURLProtocol.requestHandler = { request in
            let response = FakeTranslationResponse.responseError
            return (response, data)
        }

        let translationRepository = TranslationRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should not succeed")
        let failureExpectation = expectation(description: "should fail")
        successExpectation.isInverted = true

        do {
            let _ = try await translationRepository.translate(source: "Anglais")
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_wrong_data() async{
        let data = FakeTranslationResponse.translationWrongData

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = FakeTranslationResponse.responseOk
            return (response, data)
        }

        let translationRepository = TranslationRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should not succeed")
        let failureExpectation = expectation(description: "should fail")
        successExpectation.isInverted = true

        do {
            let _ = try await translationRepository.translate(source: "Anglais")
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }
}
