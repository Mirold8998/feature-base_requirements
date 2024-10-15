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
                Image(systemName: "chevron.right")
                    .padding(.trailing, 20)
            }.padding(.leading, 20)
            Divider()
        }
    }
}

#Preview {
    VehicleCardCelllView(index: 0, modelName: "BMW x1", vin: "4354BMHN4TB78")
}
