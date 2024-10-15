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
    
    // MARK: - Setup data for vehicles List Screen
    // Fetching vehicles list based on the input value from service API call
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
                debugPrint(self?.vehicleList)
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
    func configureVehicleDetails(isVehicleColor: Bool, details: VehicleListModel) -> String {
        return "\(isVehicleColor ? AppConstants.color : AppConstants.carTypeColon) \(isVehicleColor ? details.color : details.car_type)"
    }
    
    // MARK: - Input Validation
    // Validation for inputField: returns true if number not between 1 - 100
    func validationForWrongInputField() -> Bool {
        if let inputNumber = Int(self.searchText) {
            if !(1...100 ~= inputNumber) {
                return true
            }
        }
        return false
    }
    
    // Enable/Disable submit button based on input and empty values
    func submitButtonDisabled() -> Bool {
        if (self.validationForWrongInputField() || self.searchText.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Carbon Emission
    // calculate the carbon emission from KM
    func calculateCarbonEmission(kilometers: Double) -> Double {
        if kilometers <= 5000 {
            return kilometers
        } else {
            return (5000 + (kilometers - 5000) * 1.5)
        }
    }
    
    // Display total Carbon Emission string
    func configureCarbonEmissionText(kilometers: Double) -> String {
        return "\(AppConstants.carbonEmission) \(String(format: "%.0f", calculateCarbonEmission(kilometers: kilometers)))"
    }
    
    // Display total KM string
    func displayKM(kilometers: Double) -> String {
        "\(AppConstants.totalKM) \(String(format: "%.0f", kilometers))"
    }
}
