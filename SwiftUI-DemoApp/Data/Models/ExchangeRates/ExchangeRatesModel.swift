//
//  ExchangeRatesModel.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

struct ExchangeRatesModel: Codable {
    let table: String
    let no: String
    let effectiveDate: String
    let rates: [RateModel]
    
    func toEntity(element: ExchangeRatesModel) -> ExchangeRatesEntity {
        
        let rates = element.rates.map { rate in
            RateEntity(
                currency: rate.currency,
                code: rate.code, 
                mid: rate.mid
            )
        }
        
        let exchangeRatesEntity = ExchangeRatesEntity(
            table: element.table,
            no: element.no,
            effectiveDate: element.effectiveDate,
            rates: rates
            )
        
        return exchangeRatesEntity
    }
}


