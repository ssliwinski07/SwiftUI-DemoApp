//
//  ExchangeRatesRepository.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

final class ExchangeRatesRepository: ExchangeRatesRepositoryBase {
    
    private let _exchangeRatesService: ExchangeRatesService
    
    init(exchangeRatesService: ExchangeRatesService) {
        self._exchangeRatesService = exchangeRatesService
    }
    
    func getCurrentRates() async throws -> ExchangeRatesEntity {
        let data = try await _exchangeRatesService.getCurrentRates()
        let exchangeRatesEntity = data[0].toEntity(element:data[0])
        
        return exchangeRatesEntity
    }
    
}

