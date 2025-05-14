//
//  ContentViewModel.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMsg: String? = nil
    @Published var exchangeRatesEntity: ExchangeRatesEntity? = nil
    
    private let _exchangeRatesRepository: ExchangeRatesRepositoryBase
    
    init(exchangeRatesRepository: ExchangeRatesRepositoryBase) {
        self._exchangeRatesRepository = exchangeRatesRepository
    }
    
    func getCurrentRates(table: String) async throws {
        self.isLoading = true
        self.errorMsg = nil
        
        do {
            //simulation of delay
            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            let rates = try await _exchangeRatesRepository.getCurrentRates(table: table)

            self.exchangeRatesEntity = rates
            self.isLoading = false
        } catch let error as GeneralErrors {
            self.errorMsg = error.localizedDescription
            self.isLoading = false
            
            throw error
        } catch {
            self.errorMsg = error.localizedDescription
            self.isLoading = false
            
            throw error
        }
    }
}
