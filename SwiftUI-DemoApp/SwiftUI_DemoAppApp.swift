//
//  SwiftUI_DemoAppApp.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

import SwiftUI

@main

struct SwiftUI_DemoAppApp: App {
    
    
    init(){
        _appInit()
    }
    
    var body: some Scene {
   
        WindowGroup {
            ContentView()
        }
    }
    
    private func _appInit() {
        #if DEBUG
        ServiceLocator.I.setupContainerMock()
        ServiceLocator.I.setupContainerProd()
        print("Running in debug mode")
        #else
        ServiceLocator.I.setupContainerProd()
        print("Running in prod mode")
        #endif
    }
}
