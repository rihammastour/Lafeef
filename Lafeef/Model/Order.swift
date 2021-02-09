//
//  Order.swift
//  Lafeef
//
//  Created by Renad nasser on 08/02/2021.
//

import Foundation
import UIKit
struct Order: Codable {
    var allTime:Int
    var base:String
    var size:Int
    var toppings:[String:Int]?
    
    func showOrder() ->  OrderViewController {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        let orderVC = storyboard.instantiateViewController(identifier: Constants.Storyboard.orderVirwController) as OrderViewController
      //TODO: Pass Info
        orderVC.order = self
        
        return orderVC
      }
    
}

