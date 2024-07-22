//
//  CurrencyRepositoryTestCase.swift
//  voyageTests
//
//  Created by Hugo Blas on 20/06/2024.
//

import XCTest
@testable import voyage

final class CurrencyRepositoryTestCase: XCTestCase {
    
    func test_success() async {
        let data = FakeCurrencyResponse.currencyCorrectData

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = FakeCurrencyResponse.responseOk
            return (response, data)
        }

        let currencyRepository = CurrencyRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should succeed")
        let failureExpectation = expectation(description: "should not fail")
        failureExpectation.isInverted = true

        do {
            let _ = try await currencyRepository.getExchangeRates()
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_error() async {
        let data = FakeCurrencyResponse.currencyCorrectData

        MockURLProtocol.error = FakeCurrencyResponse.error
        MockURLProtocol.requestHandler = { request in
            let response = FakeCurrencyResponse.responseError
            return (response, data)
        }

        let currencyRepository = CurrencyRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should not succeed")
        let failureExpectation = expectation(description: "should fail")
        successExpectation.isInverted = true

        do {
            let _ = try await currencyRepository.getExchangeRates()
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_wrong_data() async{
        let data = FakeCurrencyResponse.currencyWrongData

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = FakeCurrencyResponse.responseOk
            return (response, data)
        }

        let currencyRepository = CurrencyRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should not succeed")
        let failureExpectation = expectation(description: "should fail")
        successExpectation.isInverted = true

        do {
            let _ = try await currencyRepository.getExchangeRates()
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_write_to_file() {
        let data = FakeCurrencyResponse.currencyCorrectData
        let currencyRepository = CurrencyRepository(client: MockAPIClient())

        if let rates = try? JSONDecoder().decode(RatesResponse.self, from: data) {
            currencyRepository.writeToFile(rates: rates)
        }
    }
 }
