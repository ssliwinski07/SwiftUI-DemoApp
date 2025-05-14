//
//  NetworkManager.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 12/05/2025.
//

import Moya
import Foundation


final class NetworkManager {
    
    private let provider: MoyaProvider<MultiTarget>
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        let session = Session(configuration: config)
        let plugins: [PluginType] = [GeneralQueryParameters()]
        
        self.provider = MoyaProvider<MultiTarget>(session: session, plugins: plugins)
    }
    
    private static let _shared = NetworkManager()
    
    public static var shared: NetworkManager {
        return _shared
    }
    
    func request<T: TargetType, R: Decodable> (_ target: T, type: R.Type) async throws -> R {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(R.self, from: response.data)
                        continuation.resume(returning: decoded)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


