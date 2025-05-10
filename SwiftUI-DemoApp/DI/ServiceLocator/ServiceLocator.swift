//
//  ServiceLocator.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

import Swinject

final class ServiceLocator {
    
    private init() {}
    
    private static let _instance = ServiceLocator()
    
    private let _container = Container()
    
    public static var I: ServiceLocator {
        return _instance
    }
    
    func setupContainerProd() {
        // services registration - use "prod" for names
        ServiceLocator.I._register(serviceType: CarService.self, name: "prod") { CarService() }
        
        // repository registration - use "prod" for names
        ServiceLocator.I._register(serviceType: CarRepositoryBase.self, name: "prod") { CarRepository(carService: ServiceLocator.I.get(serviceType: CarService.self, name: "prod")) }
    }
    
    func setupContainerMock() {
        // repostiory registration - use "mock" for names
        ServiceLocator.I._register(serviceType: CarRepositoryBase.self, name: "mock") { CarRepositoryMock() }
    }
    
    func get<Service>(serviceType: Service.Type, name: String) -> Service {
        return _container.resolve(serviceType, name: name)!
    }
    
    private func _register<Service>(serviceType: Service.Type, name: String, factory: @escaping () -> Service) {
        _container.register(serviceType, name: name) { _ in factory() }
    }
    
}
