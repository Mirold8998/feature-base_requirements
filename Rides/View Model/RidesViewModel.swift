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
    private var disposables = Set<AnyCancellable>()
    
    func fetchVehicles(noOfVehicle: String) {
        // Dismiss Keyboard 
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        let photosFetcher: VehiclesFetchable = FetchVehicleListAPI(size: noOfVehicle)
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
                print(self?.vehicleList ?? "No data")
            }
            .store(in: &disposables)
    }
    
    func sortBy(type: sortBy, defaultVehicalList: [VehicleListModel]) -> [VehicleListModel] {
        switch type {
        case .vin:
            return defaultVehicalList.sorted(by: {$0.vin < $1.vin})
        case .carType:
            return defaultVehicalList.sorted(by: {$0.car_type < $1.car_type})
        }
    }
    
    func giveMeVehicleDetails(isVehicleColor: Bool, details: VehicleListModel) -> String {
        return "\(isVehicleColor ? AppConstants.color : AppConstants.carTypeColon) \(isVehicleColor ? details.color : details.car_type)"
    }
}
