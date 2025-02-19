//
//  AdressViewModel.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 12.02.25.
//

import Foundation


class AdressViewModel: ObservableObject {
    
    @Published var showTextFields: Bool = false
    
    @Published var firstName: String = ""
    @Published var secondName: String = ""
    @Published var street: String = ""
    @Published var houseNumber: String = ""
    @Published var plz: String = ""
    @Published var location: String = ""
    @Published var selectedAdressOption: String = ""
    
}
