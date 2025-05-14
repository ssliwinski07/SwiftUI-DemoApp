//
//  PeopleApi.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 12/05/2025.
//
import Moya
import Foundation

enum ExchangeRatesApi {
    case getCurrentRates(table: String)
}

extension ExchangeRatesApi: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkBaseApi.nbpUrl)!
    }
    
    var path: String {
        switch self {
        case .getCurrentRates(let table):
            return "/exchangerates/tables/\(table)/"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getCurrentRates(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
}
