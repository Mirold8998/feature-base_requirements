//
//  APIErrors.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import Foundation

enum APIErrors: Error {
    case request(message: String)
    case network(message: String)
    case status(message: String)
    case parsing(message: String)
    case other(message: String)
    
    static func map(_ error: Error) -> APIErrors {
        return (error as? APIErrors) ?? .other(message: error.localizedDescription)
    }

}
