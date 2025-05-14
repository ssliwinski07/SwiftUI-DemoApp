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
                HStack {
                    if (_viewModel.exchangeRatesEntity != nil && !_viewModel.isLoading && _viewModel.errorMsg == nil) {
                        ZStack {
                            Text(_viewModel.exchangeRatesEntity?.effectiveDate ?? "-")
                            HStack {
                                Spacer()
                                 Text("\((_viewModel.currentPage))/\(_viewModel.allPages)")
                            }
                        }
                    }
                }
                
                Spacer()
                
                Group {
                    switch(_viewModel.isLoading, _viewModel.errorMsg, _viewModel.exchangeRatesEntity) {
                        case (true, _, _):
                            ProgressView()
                        case (_, let error?, _):
                            Text(error)
                        case (_, _, let rates?):
                            List(rates.rates, id: \.self) { rate in
                                VStack {
                                    HStack {
                                        Text(rate.currency)
                                        Spacer()
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
                        default:
                            Text("\(GeneralErrors.customMessage(message: "No data"))")
                        }
                }
                
                Spacer()
                
                HStack {
                    ZStack {
                        Text("Refresh")
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                Task {
                                    try await _viewModel.refreshData()
                                }
                            }
                        HStack {
                            if _viewModel.tableIndex > 0 {
                                Image(systemName: "chevron.left")
                                    .padding(.leading, 16)
                                    .onTapGesture {
                                        Task {
                                            try await _viewModel.previous()
                                        }
                                    }
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            if _viewModel.tableIndex < _viewModel.tableParamLengthLimit {
                                Image(systemName: "chevron.right")
                                    .padding(.trailing, 16)
                                    .onTapGesture {
                                        Task {
                                            try await _viewModel.next()
                                        }
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .allowsHitTesting(!_viewModel.isLoading)
                    .opacity(_viewModel.isLoading ? 0.5 : 1.0)
                    
                }
                .padding(.bottom, 16)
            }
            .padding()
            .onAppear {
                Task {
                    try await _viewModel.getCurrentRates()
                }
            }
        }
    
}

//#Preview {
 //   ContentView()
//}
