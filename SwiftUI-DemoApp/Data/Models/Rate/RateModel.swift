//
//  RatesModel.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

struct RateModel: Codable {
    let currency: String
    let code: String
    let mid: Double
    
    func toEntity(element: RateModel) -> RateEntity {
        let rateEntity = RateEntity(
            currency: element.currency,
            code: element.code,
            mid: element.mid
        )
        
        return rateEntity
    }
}


