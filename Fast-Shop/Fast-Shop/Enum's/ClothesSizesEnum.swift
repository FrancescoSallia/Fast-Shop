//
//  SizesEnum.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 31.01.25.
//

import Foundation

enum ClothesSizesEnum: String, CaseIterable {
    case XS
    case S
    case M
    case L
    case XL
    case XXL
    
    
    var clothesSizes: String {
        switch self {
        case .XS:
            return "XS"
        case .S:
            return "S"
        case .M:
            return "M"
        case .L:
            return "L"
        case .XL:
            return "XL"
        case .XXL:
            return "XXL"
        }
    }

    func shoesSizesToString() -> String {
        switch self {
        case .XS:
            return "XS"
        case .S:
            return "S"
        case .M:
            return "M"
        case .L:
            return "L"
        case .XL:
            return "XL"
        case .XXL:
            return "XXL"
        }
    }
}


