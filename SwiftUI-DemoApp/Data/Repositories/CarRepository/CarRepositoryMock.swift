//
//  CarRepositoryMock.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

class CarRepositoryMock: CarRepositoryBase {
    func fetchCars() async -> [String] {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        return ["Opel Astra", "Ford F150"]
    }
}
