//
//  ExchangeRatesRepositoryBase.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

protocol ExchangeRatesRepositoryBase {
    func getCurrentRates() async throws -> ExchangeRatesEntity
}
