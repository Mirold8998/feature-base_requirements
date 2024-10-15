//
//  VehicleCardCelllView.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import SwiftUI

struct VehicleCardCelllView: View {
    let index: Int
    let modelName: String
    let vin: String
    let showRightChevron: Bool
    var body: some View {
        VStack {
            HStack {
                Text("\(index)")
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                Text(modelName)
                    .padding()
                    .font(.headline)
                Spacer()
            }.padding()
            
            HStack() {
                Text("\(AppConstants.vinTitle)\(vin)")
                Spacer()
                if showRightChevron {
                    Image(systemName: AppConstants.Images.chevronRight)
                        .padding(.trailing, 20)
                }
            }.padding(.leading, 20)
            Divider()
        }
    }
}

#Preview {
    VehicleCardCelllView(index: 0, modelName: AppConstants.sampleCarModel, vin: AppConstants.sampleVin, showRightChevron: true)
}
