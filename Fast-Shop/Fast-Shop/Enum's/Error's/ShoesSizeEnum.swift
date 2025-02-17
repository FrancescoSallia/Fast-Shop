//
//  ShoesSizeEnum.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 15.02.25.
//

import Foundation

enum ShoesSizeEnum: String, CaseIterable {
    
    case g40
    case g41
    case g42
    case g43
    case g44
    case g45
    
    func getSizeToString() -> String {
        switch self {
            case .g40:
            return "40"
        case .g41:
            return "41"
        case .g42:
            return "42"
        case .g43:
            return "43"
        case .g44:
            return "44"
        case .g45:
            return "45"
        }
    }
}
