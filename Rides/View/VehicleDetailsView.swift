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
    
    // MARK: - Vehicle Details
    // Display additional fields on Vehicle Details
    var vehicleDetailsPage: some View {
        VStack {
            VehicleCardCelllView(index: index+1, modelName: vehicleDetails.make_and_model, vin: vehicleDetails.vin, showRightChevron: false)
            vehicleAdditionalDetails(displayVehicleColor: true)
            vehicleAdditionalDetails(displayVehicleColor: false)
            Divider()
            Text(AppConstants.note)
                .foregroundStyle(.green)
                .multilineTextAlignment(.center)
                .padding([.top, .bottom], 50)
            Divider()
            Spacer()
        }
    }
    
    // Reusable View function to display color and type
    func vehicleAdditionalDetails(displayVehicleColor: Bool) -> some View {
        HStack {
            Text(viewModel.configureVehicleDetails(isVehicleColor: displayVehicleColor, details: vehicleDetails))
                .padding([.leading, .top], 20)
            Spacer()
        }
    }
    
    // MARK: - Vehicle Details with Carbon Emission
    var vehicleCarbonEmissionPage: some View {
        VStack {
            Spacer()
            Divider()
            Text(viewModel.displayKM(kilometers: vehicleDetails.kilometrage)).padding()
            Text(viewModel.configureCarbonEmissionText(kilometers: vehicleDetails.kilometrage))
            Divider()
            Spacer()
        }
    }
}
