//
//  AlertService.swift
//  Lafeef
//
//  Created by Mihaf on 17/06/1442 AH.
//

import UIKit
class AlertService {
    func Alert(body:String, isSuccess:Bool) ->  AlertViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AlertVc = storyboard.instantiateViewController(identifier: "alert") as AlertViewController
      print(AlertVc)
        AlertVc.body = body
        AlertVc.isSuccess = isSuccess
        
        return AlertVc
      }
    func logoutAlert() ->  LogoutViewController {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let AlertVc = storyboard.instantiateViewController(identifier: "logout") as LogoutViewController
        print(AlertVc)
          
          return AlertVc
        }
  
}
