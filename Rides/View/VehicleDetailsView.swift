//
//  VehicleDetailsView.swift
//  Rides
//
//  Created by Mirold Dabre on 10/14/24.
//

import SwiftUI

struct VehicleDetailsView: View {
    @ObservedObject var viewModel: VehicleListViewModel
    let vehicleDetails: VehicleListModel
    let index: Int
    
    var body: some View {
        TabView {
            vehicleDetailsPage
            vehicleCarbonEmissionPage
        }.tabViewStyle(.page(indexDisplayMode: .automatic))
            .navigationTitle(AppConstants.vehicleDetails)
    }
    
    var vehicleDetailsPage: some View {
        VStack {
            VehicleCardCelllView(index: index+1, modelName: vehicleDetails.make_and_model, vin: vehicleDetails.vin)
            vehicleAdditionalDetails(displayVehicleColor: true)
            vehicleAdditionalDetails(displayVehicleColor: false)
            Divider()
            Spacer()
        }
    }
    
    var vehicleCarbonEmissionPage: some View {
        VStack {
            Text(viewModel.displayKM(km: vehicleDetails.kilometrage)).padding()
            Text(viewModel.calculateCarbonEmission(kilometers: vehicleDetails.kilometrage))
            Divider()
            Spacer()
        }
    }
    
    // Reusable function to display color and type
    func vehicleAdditionalDetails(displayVehicleColor: Bool) -> some View {
        HStack {
            Text(viewModel.giveMeVehicleDetails(isVehicleColor: displayVehicleColor, details: vehicleDetails))
                .padding([.leading, .top], 20)
            Spacer()
        }
    }
}
