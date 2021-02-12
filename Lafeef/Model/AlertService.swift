//
//  AlertService.swift
//  Lafeef
//
//  Created by Mihaf on 17/06/1442 AH.
//

import UIKit
class AlertService {
    func Alert(body:String) ->  AlertViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AlertVc = storyboard.instantiateViewController(identifier: "alert") as AlertViewController
      print(AlertVc)
        AlertVc.body = body
        return AlertVc
      }
  
}
