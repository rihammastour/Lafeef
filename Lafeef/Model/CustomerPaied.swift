//
//  CustomerPaied.swift
//  Lafeef
//
//  Created by Riham Mastour on 08/07/1442 AH.
//

import Foundation

class CustomerPaied {
    
    static func convertToMoney(customerPaied: Float) -> [Money]{
        switch customerPaied {
        case 100.0:
            return mapCustomerPaied(customerPaied: [50, 50])
        case 60.0:
            return mapCustomerPaied(customerPaied: [50, 10])
        case 59.0:
            return mapCustomerPaied(customerPaied: [50, 5, 1, 1, 1, 1])
        case 56.0:
            return mapCustomerPaied(customerPaied: [50, 5, 1])
        case 50.0:
            return mapCustomerPaied(customerPaied: [50])
        case 53.0:
            return mapCustomerPaied(customerPaied: [50, 1, 1, 1])
        case 35.0:
            return mapCustomerPaied(customerPaied: [10, 10, 10, 5])
        case 20:
            return mapCustomerPaied(customerPaied: [10, 10])
        case 19:
            return mapCustomerPaied(customerPaied: [10, 5, 1, 1, 1, 1])
        case 16:
            return mapCustomerPaied(customerPaied: [10, 5, 1])
        default:
            return []
        }
    }
    
    
    static func mapCustomerPaied(customerPaied: [Float]) -> [Money]{
        switch customerPaied {
        case [50, 50]:
            return [.fiftyRiyal, .fiftyRiyal]
        case [50, 10]:
            return [.fiftyRiyal, .tenRiyal]
        case [50, 5, 1, 1, 1, 1]:
            return [.fiftyRiyal, .fiveRiyal, .riyal, .riyal, .riyal, .riyal]
        case [50, 5, 1]:
            return [.fiftyRiyal, .fiveRiyal, .riyal]
        case [50]:
            return [.fiftyRiyal]
        case [50, 1, 1, 1]:
            return [.fiftyRiyal, .riyal, .riyal, .riyal]
        case [10, 10, 10, 5]:
            return [.tenRiyal, .tenRiyal, .tenRiyal, .fiveRiyal]
        case [10, 10]:
            return [.tenRiyal, .tenRiyal]
        case [10, 5, 1, 1, 1, 1]:
            return [.tenRiyal, .fiveRiyal, .riyal, .riyal, .riyal, .riyal]
        case [10, 5, 1]:
            return [.tenRiyal, .fiveRiyal, .riyal]
        default:
            return []
        }
    }
}
