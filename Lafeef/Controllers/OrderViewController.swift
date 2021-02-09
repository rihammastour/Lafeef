//
//  OrderViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 09/02/2021.
//

import UIKit

class OrderViewController: UIViewController {

    //MARK: - Proprites
    var order:Order?
    
    @IBOutlet weak var orderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Additional setup after loading the view.
        orderLabel.text = order?.base
        print("Order VC Eexcuted")
    }
    

}
