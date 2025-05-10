//
//  ContentView.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var isTextChanged = false
    @State var isIconSizeChanged = false
    
    var textFirstOption = "Hello world"
    var textSecondOption = "Hi, world :)"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: isIconSizeChanged ? 100 : 50, height: isIconSizeChanged ? 100 : 50)
                .imageScale(.large)
                .foregroundStyle(.tint)
                .onTapGesture {
                    isIconSizeChanged.toggle()
                }
           
            Text(isTextChanged ? textFirstOption : textSecondOption).onAppear {
                let carRepository = ServiceLocator.I.get(serviceType: CarRepositoryBase.self, name: "prod")
                Task {
                    await print(carRepository.fetchCars())
                }
            }.onTapGesture {
                isTextChanged.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
