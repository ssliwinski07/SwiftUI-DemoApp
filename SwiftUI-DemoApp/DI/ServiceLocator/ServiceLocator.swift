//
//  ServiceLocator.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

import Swinject

final class ServiceLocator {
    
    private init() {}
    
    private static let _shared = ServiceLocator()
    
    private let _container = Container()
    
    public static var shared: ServiceLocator {
        return _shared
    }
    
    func setupContainerProd() {
        
        // network modules - use "prod" for names
        self._register(serviceType: NetworkManager.self, name: "prod") { NetworkManager.shared }
        
        // services registration - use "prod" for names
        self._register(serviceType: ExchangeRatesService.self, name: "prod") { ExchangeRatesService(networkManager: self.get(serviceType: NetworkManager.self, name: "prod")) }
        
        // repository registration - use "prod" for names
        self._register(serviceType: ExchangeRatesRepositoryBase.self, name: "prod") { ExchangeRatesRepository(exchangeRatesService: self.get(serviceType: ExchangeRatesService.self, name: "prod")) }
    }
    
    func setupContainerMock() {
        // repostiory registration - use "mock" for names
    }
    
    func get<Service>(serviceType: Service.Type, name: String) -> Service {
        return _container.resolve(serviceType, name: name)!
    }
    
    private func _register<Service>(serviceType: Service.Type, name: String, factory: @escaping () -> Service) {
        _container.register(serviceType, name: name) { _ in factory() }
    }
    
}
