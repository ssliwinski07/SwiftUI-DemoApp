//
//  ExchangeRatesService.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

import Foundation

final class ExchangeRatesService {
    
    private let _networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self._networkManager = networkManager
    }
    
    func getCurrentRates(table: String) async throws -> [ExchangeRatesModel] {

        let response: [ExchangeRatesModel] = try await _networkManager.request(ExchangeRatesApi.getCurrentRates(table: table), type: [ExchangeRatesModel].self)
        
        guard !response.isEmpty else {
            throw GeneralErrors.noData
        }

        return response
    }
}
