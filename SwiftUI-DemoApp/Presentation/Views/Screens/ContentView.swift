//
//  ContentView.swift
//  SwiftUI-DemoApp
//
//  Created by Szymon Śliwiński on 10/05/2025.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var _viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self._viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            switch(_viewModel.isLoading, _viewModel.errorMsg, _viewModel.exchangeRatesEntity) {
            case (true, _, _):
                ProgressView()
            case (_, let error?, _):
                Text(error)
            case (_, _, let rates?):
                if let firstRate = rates.rates.first {
                    Text(firstRate.code)
                }
            default:
                Text("\(GeneralErrors.customMessage(message: "No data"))")
                
            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    try await _viewModel.getCurrentRates()
                    print(_viewModel.exchangeRatesEntity!)
                } catch let error as GeneralErrors {
                    print("Error:", error.localizedDescription)
                } catch {
                    print("Error:", error)
                }
              
            }
        }
    }
}

//#Preview {
 //   ContentView()
//}
