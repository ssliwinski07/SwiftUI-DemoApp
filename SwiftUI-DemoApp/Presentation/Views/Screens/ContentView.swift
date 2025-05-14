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
                VStack {
                    Text(rates.effectiveDate)
                    
                    List(rates.rates, id: \.self) { rate in
                        VStack {
                            HStack {
                                Text(rate.currency)
                                Text("\(String(format: "%.2f", rate.mid)) PLN")
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                    .padding(.bottom, 16)
                    
                    Spacer()
                    
                    Text("Refresh")
                        .foregroundColor(.blue)
                        .padding(.bottom, 16)
                        .onTapGesture {
                            Task {
                                try await _viewModel.getCurrentRates(table: "A")
                            }
                        }
                }
            default:
                Text("\(GeneralErrors.customMessage(message: "No data"))")
                
            }
        }
        .padding()
        .onAppear {
            Task {
                try await _viewModel.getCurrentRates(table: "A")
            }
        }
    }
}

//#Preview {
 //   ContentView()
//}
