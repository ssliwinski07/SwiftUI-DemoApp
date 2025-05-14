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
    
    private var _currentPage: Int = 1
    private var _allPages: Int = 0
    private var _tableIndex: Int = 0
    private var _tableParam: [String] = ["A","B","C"]
    private let _exchangeRatesRepository: ExchangeRatesRepositoryBase
    
    var tableParamLengthLimit: Int {
        get {
            return _tableParam.count - 1
        }
    }
    
    var currentPage: Int {
        get {
            return _currentPage
        }
    }
    
    var allPages: Int {
        get {
            return _allPages
        }
    }
    
    var tableIndex: Int {
        get {
            return _tableIndex
        }
    }
    
    init(exchangeRatesRepository: ExchangeRatesRepositoryBase) {
        self._exchangeRatesRepository = exchangeRatesRepository
        _allPages = _tableParam.count
    }
    
    func next() async throws {
        if (_tableIndex < _tableParam.count - 1) {
            _currentPage += 1
            _tableIndex += 1
            try await getCurrentRates(table: _tableParam[_tableIndex])
        }
    }
    
    func previous() async throws {
        if (_tableIndex > 0) {
            _currentPage -= 1
            _tableIndex -= 1
            try await getCurrentRates(table: _tableParam[_tableIndex])
        }
    }
    
    func refreshData() async throws {
        try await getCurrentRates(table: _tableParam[_tableIndex])
    }
    
    func getCurrentRates(table: String? = nil) async throws {
                
        let defaultTable: String = table ?? _tableParam[0]
        
        self.isLoading = true
        self.errorMsg = nil
        
        do {
            defer {
                self.isLoading = false
            }
            //simulation of delay
            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            // tableParam[0] = "A" which is supposed to be the main and default table to pass in path of API method
            
            let rates = try await _exchangeRatesRepository.getCurrentRates(table: defaultTable)

            self.exchangeRatesEntity = rates
        } catch let error as GeneralErrors {
            self.errorMsg = error.localizedDescription
            
            throw error
        } catch {
            self.errorMsg = error.localizedDescription
            
            throw error
        }
    }
}
