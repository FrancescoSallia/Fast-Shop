//
//  errorEnum.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 21.01.25.
//

import Foundation
import FirebaseAuth

enum ErrorEnum: LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noProducts
    case emailAlreadyInUse
    case weakPassword
    case unknownError
    case custom(String)

    init(from error: Error) {
        if let nsError = error as NSError?, let authErrorCode = AuthErrorCode(rawValue: nsError.code) {
            switch authErrorCode {
            case .networkError:
                self = .networkError(error)
            case .emailAlreadyInUse:
                self = .emailAlreadyInUse
            case .weakPassword:
                self = .weakPassword
            default:
                self = .unknownError
            }
        } else {
            self = .custom(error.localizedDescription)
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "A network error has occurred: \(error.localizedDescription)"
        case .invalidURL:
            return "Invalid URL."
        case .emailAlreadyInUse:
            return "This email address is already in use."
        case .weakPassword:
            return "Please choose a stronger password."
        case .unknownError:
            return "An unknown error has occurred."
        case .custom(let message):
            return message
        case .decodingError(let error):
            return "Could not decode data: \(error.localizedDescription)"
        case .noProducts:
            return "No products found."
        }
    }
}
