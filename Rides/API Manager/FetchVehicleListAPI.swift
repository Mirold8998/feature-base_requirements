//
//  FetchVehicleListAPI.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import Foundation
import Combine

protocol VehiclesFetchable {
    func fetchPhotosList() -> AnyPublisher<[VehicleListModel], APIErrors>
}

class FetchVehicleListAPI {
    private let session: URLSession
    let size: String
    init(session: URLSession = .shared, size: String) {
        self.session = session
        self.size = size
    }
}

private extension FetchVehicleListAPI {
    struct VehicleAPIComponent {
        static let scheme = "https"
        static let host = AppConstants.API.hostName
        static let path = AppConstants.API.path
    }
    
    func urlComponentForPhotosList() -> URLComponents {
        var components = URLComponents()
        components.scheme = VehicleAPIComponent.scheme
        components.host = VehicleAPIComponent.host
        components.path = VehicleAPIComponent.path
        components.queryItems = [
            URLQueryItem(name: "size", value: self.size),
        ]
        
        return components
    }
}


extension FetchVehicleListAPI: VehiclesFetchable, Fetchable {
    func fetchPhotosList() -> AnyPublisher<[VehicleListModel], APIErrors> {
        return fetch(with: self.urlComponentForPhotosList(), session: self.session)
    }
}
