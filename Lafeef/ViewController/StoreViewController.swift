//
//  StoreViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 28/01/2021.
//

import UIKit

class StoreViewController: UIViewController {
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Functions


    //MARK: - @IBAcation
    @IBAction func goBackTapped(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        
        if sender.selectedSegmentIndex == 0{
            testLabel.text = "Store Screen"
        } else if sender.selectedSegmentIndex == 1{
            testLabel.text = "Store Screen - Store"
        }
    }
    
}
