//
//  NetworkError.swift
//  PokedexCodable
//
//  Created by Jake Gloschat on 2/28/23.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Unable to reach the server."
        case .thrownError(let error):
            return "Thrown Error: \(error.localizedDescription)"
        case .noData:
            return "No data. The server responded with no data."
        case .unableToDecode:
            return "Unrecognized data format. Unable to decode data."
        }
    }
}
