//
//  WeatherRepositoyTestCase.swift
//  voyageTests
//
//  Created by Hugo Blas on 05/07/2024.
//

import XCTest
@testable import voyage

final class WeatherRepositoryTestCase: XCTestCase {
    func test_success() async {
        let data = FakeWeatherResponse.weatherCorrectData

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = FakeWeatherResponse.responseOk
            return (response, data)
        }

        let weatherRepository = WeatherRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should succeed")
        let failureExpectation = expectation(description: "should not fail")
        failureExpectation.isInverted = true

        do {
            let _ = try await weatherRepository.getWeather(city: City.nyc)
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_failure() async {
        let data = FakeWeatherResponse.weatherCorrectData

        MockURLProtocol.error = FakeWeatherResponse.error
        MockURLProtocol.requestHandler = { request in
            let response = FakeWeatherResponse.responseError
            return (response, data)
        }

        let weatherRepository = WeatherRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should not succeed")
        let failureExpectation = expectation(description: "should fail")
        successExpectation.isInverted = true

        do {
            let _ = try await weatherRepository.getWeather(city: City.nyc)
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }

    func test_wrong_data() async{
        let data = FakeWeatherResponse.weatherWrongData

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = FakeWeatherResponse.responseOk
            return (response, data)
        }

        let  weatherRepository = WeatherRepository(client: MockAPIClient())

        let successExpectation = expectation(description: "should not succeed")
        let failureExpectation = expectation(description: "should fail")
        successExpectation.isInverted = true

        do {
            let _ = try await weatherRepository.getWeather(city: City.nyc)
            successExpectation.fulfill()
        } catch {
            failureExpectation.fulfill()
        }

        await fulfillment(of: [successExpectation, failureExpectation], timeout: 5.0)
    }
}
