//
//  PeopleApi.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 12/05/2025.
//
import Moya
import Foundation

enum ExchangeRatesApi {
    case getCurrentRates(query: [String: Any]?)
}

extension ExchangeRatesApi: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkBaseApi.nbpUrl)!
    }
    
    var path: String {
        switch self {
        case .getCurrentRates:
            return "/exchangerates/tables/A/"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getCurrentRates(let query):
            if let query = query {
                return .requestParameters(parameters: query, encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
}
