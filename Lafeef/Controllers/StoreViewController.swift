//
//  StoreViewController.swift
//  Lafeef
//
//  Created by Mihaf on 05/08/1442 AH.
//

import UIKit
import FirebaseStorage

class StoreViewController: UIViewController {
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
}

