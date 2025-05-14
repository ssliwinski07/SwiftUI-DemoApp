//
//  QueryParameters.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 14/05/2025.
//

import Moya
import Foundation

final class GeneralQueryParameters: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) else {
            return request
        }
        
        var queryItems = urlComponents.queryItems ?? []
        var modifiedHttpRequest = request
        
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        urlComponents.queryItems = queryItems
        modifiedHttpRequest.url = urlComponents.url
        
        print(modifiedHttpRequest)
        
        return modifiedHttpRequest
    }
}
