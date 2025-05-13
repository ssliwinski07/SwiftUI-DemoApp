//
//  SwiftUI_DemoAppApp.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

import SwiftUI

@main

struct SwiftUI_DemoAppApp: App {
    
    @StateObject private var contentViewModel = ContentViewModel(exchangeRatesRepository: ServiceLocator.shared.get(serviceType: ExchangeRatesRepositoryBase.self, name: "prod"))
    
    init(){
        _appInit()
    }
    
    var body: some Scene {
      
        WindowGroup {
            ContentView(viewModel: contentViewModel)
        }
    }
    
    private func _appInit() {
        #if DEBUG
        ServiceLocator.shared.setupContainerMock()
        ServiceLocator.shared.setupContainerProd()
        
        print("Running in debug mode")
        #else
        ServiceLocator.I.setupContainerProd()
        print("Running in prod mode")
        #endif
    }
}
