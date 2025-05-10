//
//  CarRepository.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

final class CarRepository: CarRepositoryBase {
    private let _carService: CarService
    
    init(carService: CarService) {
        self._carService = carService
    }
    
    func fetchCars() async -> [String] {
       await self._carService.fetchCars()
    }
}
