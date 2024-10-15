//
//  RidesApp.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import SwiftUI

@main
struct RidesApp: App {
    let viewModel = VehicleListViewModel()
    var body: some Scene {
        WindowGroup {
            VehicleListView(viewModel: viewModel)
        }
    }
}
