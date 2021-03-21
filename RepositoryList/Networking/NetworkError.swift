//
//  NetworkError.swift
//  ListOfElements
//
//  Created by Darya Kuliashova on 18.03.21.
//

import Foundation

enum NetworkError: Error {
    case unableToLoad
    case unknownError
    
    init(errorCode: Int) {
        switch errorCode {
        case NSURLErrorCannotLoadFromNetwork:
            self = .unableToLoad
        default:
            self = .unknownError
        }
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableToLoad:
            return "Cannot load data"
        default:
            return "Something went wrong"
        }
    }
}
