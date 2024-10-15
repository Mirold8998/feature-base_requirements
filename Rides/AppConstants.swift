//
//  AppConstants.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import Foundation
import SwiftUI

struct AppConstants {
    
    static let inputnoOfVehicles = "1 to 100"
    static let sortBy = "Sort By"
    static let vin = "Vin"
    static let vinTitle = "VIN: "
    static let carType = "Car Type"
    static let carTypeColon = "Car Type:"
    static let submit = "Submit"
    static let vehicleDetails = "Vehicle Details"
    static let color = "Color:"
    static let correctionMessage = "Enter an integer value between 1 to 100"
    static let carbonEmission = "Carbon Emission:"
    static let totalKM = "Total Kilometers:"
    static let sampleCarModel = "BMW x1"
    static let sampleVin = "4354BMHN4TB78"
    static let note = "**Note:** Scroll or Swipe horizontally to see carbon emission result"
    
    struct Images {
        static let xmarkCircle = "xmark.circle"
        static let magnifyingglassImage = "magnifyingglass"
        static let chevronRight = "chevron.right"
    }
    
    struct API {
        static let hostName = "random-data-api.com"
        static let path = "/api/vehicle/random_vehicle"
        static let invalidURL = "Invalid URL"
    }
}
