//
//  CarRepositoryBase.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

protocol CarRepositoryBase {
    func fetchCars() async -> [String]
}
