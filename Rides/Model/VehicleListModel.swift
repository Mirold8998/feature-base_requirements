//
//  VehicleListModel.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import Foundation

struct VehicleListModel: Codable, Identifiable {
    var id: Int
    var uid: String
    var vin: String
    var make_and_model: String
    var color: String
    var transmission: String
    var drive_type: String
    var fuel_type: String
    var car_type: String
    var doors: Int
    var mileage: Int
    var kilometrage: Double
    var license_plate: String
}
