//
//  GeneralErrors.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 13/05/2025.
//

enum GeneralErrors: Error {
    case customMessage(message: String)
    case noData
    
    var localizedDescription: String {
        switch self {
        case .customMessage(let message):
            return message
        case .noData:
            return "No data available"
        }
    }
}
