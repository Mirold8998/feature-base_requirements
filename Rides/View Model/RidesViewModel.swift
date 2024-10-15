//
//  RidesViewModel.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import Foundation
import Combine
import SwiftUI

class VehicleListViewModel: ObservableObject {
    @Published var vehicleList = [VehicleListModel]()
    @Published var searchText: String = ""
    private var disposables = Set<AnyCancellable>()
    
    // Fetching vehicles list based on the input value
    func fetchVehicles() {
        // Dismiss Keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        let photosFetcher: VehiclesFetchable = FetchVehicleListAPI(size: self.searchText)
        photosFetcher.fetchPhotosList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.vehicleList = [VehicleListModel]()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] vehiclesResponse in
                self?.vehicleList = self?.sortBy(type: .vin, defaultVehicalList: vehiclesResponse) ?? []
            }
            .store(in: &disposables)
    }
    
    // Sorting either by vin or car_type
    func sortBy(type: sortBy, defaultVehicalList: [VehicleListModel]) -> [VehicleListModel] {
        switch type {
        case .vin:
            return defaultVehicalList.sorted(by: {$0.vin < $1.vin})
        case .carType:
            return defaultVehicalList.sorted(by: {$0.car_type < $1.car_type})
        }
    }
    
    // Returns string for vehicle color or type
    func giveMeVehicleDetails(isVehicleColor: Bool, details: VehicleListModel) -> String {
        return "\(isVehicleColor ? AppConstants.color : AppConstants.carTypeColon) \(isVehicleColor ? details.color : details.car_type)"
    }
    
    // Validation for inputField: returns true if no. not between 1 - 100
    func validationForInputField() -> Bool {
        if let inputNumber = Int(self.searchText) {
            if !(1...100 ~= inputNumber) {
                return true
            }
        }
        return false
    }
    
    func submitButtonDisabled() -> Bool {
        if self.validationForInputField() {
            return true
        } else if searchText.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    // calculate the carbon emission from KM
    func calculateCarbonEmission(kilometers: Double) -> String {
        if kilometers <= 5000 {
            return "\(AppConstants.carbonEmission) \(String(format: "%.0f", kilometers))"
        } else {
            let carbon = (5000 + (kilometers - 5000) * 1.5)
            return "\(AppConstants.carbonEmission) \(String(format: "%.0f", carbon))"
        }
    }
    
    func displayKM(km: Double) -> String {
        return "\(AppConstants.totalKM) \(String(format: "%.0f", km))"
    }
}
