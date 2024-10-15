//
//  ContentView.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import SwiftUI

struct VehicleListView : View {
    @StateObject private var viewModel: VehicleListViewModel
    
    @State private var sortBy = 0
    init (viewModel: VehicleListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        HStack {
                            Image(systemName: AppConstants.Images.magnifyingglassImage)
                                .foregroundColor(.white)
                            TextField(AppConstants.inputnoOfVehicles, text: $viewModel.searchText)
                                .foregroundColor(.white)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                                .keyboardType(.numberPad)
                            Spacer()
                            Image(systemName: AppConstants.Images.xmarkCircle)
                                .onTapGesture {
                                    viewModel.searchText = ""
                                    viewModel.vehicleList.removeAll()
                                }
                                .foregroundColor(.white)
                                .opacity((viewModel.searchText == "") ? 0 : 1)
                        }
                        .padding(7)
                        .frame(width: 150)
                        .foregroundColor(.secondary)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        
                        if !viewModel.vehicleList.isEmpty {
                            Picker(AppConstants.sortBy, selection: $sortBy){
                                Text(AppConstants.vin).tag(0)
                                Text(AppConstants.carType).tag(1)
                            }.pickerStyle(.automatic)
                        }
                        
                        Group {
                            Button(action: {
                                viewModel.fetchVehicles()
                            }, label: {
                                Text(AppConstants.submit)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(7)
                                    .background((viewModel.submitButtonDisabled() ? .gray : .blue))
                                    .cornerRadius(10)
                            })
                        }.allowsHitTesting(!viewModel.submitButtonDisabled())
                        Spacer()
                    }
                    .padding()
                    if viewModel.validationForInputField() {
                        Text(AppConstants.correctionMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                    
                    ScrollView {
                        ForEach(Array(viewModel.vehicleList.enumerated()), id: \.1.id) { (index, vehicle) in
                            NavigationLink {
                                VehicleDetailsView(viewModel: viewModel, vehicleDetails: vehicle, index: index)
                            } label: {
                                VehicleCardCelllView(index: index+1, modelName: vehicle.make_and_model, vin: vehicle.vin)
                            }
                        }
                    }
                }.onChange(of: sortBy) { newValue in
                    viewModel.vehicleList = viewModel.sortBy(type: Rides.sortBy(rawValue: newValue) ?? .carType, defaultVehicalList: viewModel.vehicleList)
                }
            }
        }
    }
}

#Preview {
    VehicleListView(viewModel: VehicleListViewModel())
}
