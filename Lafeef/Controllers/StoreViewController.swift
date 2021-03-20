//
//  StoreViewController.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//

import UIKit
import FirebaseStorage

class StoreViewController: UIViewController {
    var alert = AlertService()
    var userPrefrence =  ChildPrefrences(childId: "", equipment: [])
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
     AddStoreEquipment.addEquipment()
        FirebaseRequest.downloadStoreEquipmentImage(type: "cupcakeFrame", completion: {(data, err)  in
            if err == nil{
          
                self.image.image = data
        }
        })

    }
    
    func addPrefrence(){
        let equipment = StoreEquipment(type: "", name: "", cost: 0, label: "")
        userPrefrence.childId = ""
        userPrefrence.equipment.append(equipment)
    }
    
    
    func alert(message :String){
        // if child money less than cost
        alert.Alert(body: message)
        
        
    }
}

