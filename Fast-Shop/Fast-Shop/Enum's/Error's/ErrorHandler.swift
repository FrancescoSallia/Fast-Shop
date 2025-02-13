//
//  ErrorHandler.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 07.02.25.
//

import Foundation


class ErrorHandler: ObservableObject {
    
    // MARK: - Properties
    
    static let shared = ErrorHandler()
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    // MARK: - Functions
    
    func handleError(error: Error) {
        let appError = ErrorEnum(from: error)
        errorMessage = appError.errorDescription ?? "Unknown Error"
        showError = true
    }
}
