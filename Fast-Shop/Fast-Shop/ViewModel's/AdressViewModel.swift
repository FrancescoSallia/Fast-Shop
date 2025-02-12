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
    
    let testAdressArray: [Adress] = [
        Adress(
            firstName: "Test",
            secondName: "secondname",
            street: "musterstrasse",
            houseNumber: "123a",
            plz: "11223",
            location: "Berlin"
        ),
        Adress(
            firstName: "Test2",
            secondName: "secondname2",
            street: "musterstrasse2",
            houseNumber: "123a",
            plz: "11223",
            location: "München"
        )
        
    ]

}
