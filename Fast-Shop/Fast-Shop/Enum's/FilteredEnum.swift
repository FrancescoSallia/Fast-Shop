//
//  FilteredEnum.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 27.01.25.
//

import Foundation

enum FilteredEnum: CaseIterable {
    
    case allCategories
    case clothes
    case electronics
    case furniture
    case miscellaneous
    
    var caseCategorie: String {
        
        switch self {
        case .allCategories: "0"
        case .clothes: "1"
        case .electronics: "2"
        case .furniture: "3"
        case .miscellaneous : "4"            
        }
    }
}


