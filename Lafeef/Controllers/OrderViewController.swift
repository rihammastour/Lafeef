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
    
    //MARK: - Outlet
    
    @IBOutlet weak var baseUIImage: UIImageView!
    @IBOutlet weak var toppingTopRightUIImage: UIImageView!
    @IBOutlet weak var toppingTopLeft: UIImageView!
    @IBOutlet weak var toppingLeftBottom: UIImageView!
    @IBOutlet weak var toppingRightBottom: UIImageView!
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //Additional setup after loading the view.
        print("Order VC Eexcuted")
        setBase()
        setToppings()
    }
    
    //MARK: - Functions
    
    //setBase
    func setBase() -> Void {
        
        let base = order?.base
        var image:UIImage?
        
        switch base {
        case "cake":
            image = UIImage(named: "cake")
        case "halfCake":
            image = UIImage(named: "half-cake")
        case "quarterCake":
            image = UIImage(named: "quarter-cake")
        case "threeQuarterCake":
            image = UIImage(named: "threequarter-cake")
        case "cupcakeCh":
            image = UIImage(named: "cupcake-ch")
        case "cupcakeVan":
            image = UIImage(named: "cupcake-van")
        default:
            image = UIImage(named: "cake")
        }
        baseUIImage.image = image
    }
    
    //setToppings
    func setToppings() ->Void {

        guard let toppingsArr = order?.toppings else {
            return
        }
        //Get toopings names spareted
        let toppings = getToppingsName(from: toppingsArr)
        var image:UIImage?
        
        for i in toppings{
            switch i {
            case "strawberry":
                image = UIImage(named: "strawberry")
            case "kiwi":
                image = UIImage(named: "kiwi-1")
            case "pineapple":
                image = UIImage(named: "pineapple")
            case "darkChocolate":
                image = UIImage(named: "dark-chocolate")
            case "whiteChocolate":
                image = UIImage(named: "white-chocolate")
            default:
                print("topping undefined")
            }
            setUITopping(with: image)
            
        }

    }
    
    //setUItooping
    func setUITopping(with image:UIImage?){
        
        guard let image = image else {
            print("topping undefined")
            return
        }
        
        if toppingTopRightUIImage.image == nil{
        toppingTopRightUIImage.image = image
            
        } else if toppingTopLeft.image == nil {
            toppingTopLeft.image = image
            
        }else if toppingLeftBottom.image == nil {
            toppingLeftBottom.image = image
            
        }else{
            toppingRightBottom.image = image
        }
        
        
    }
    
    //getToppingsName
    func getToppingsName(from array:[String:Int]) -> [String]{
        
        var toppingsName:[String] = []
        
        for (key, value) in array{
            if toppingsName.count == 4 {
                break }
            //Stract number of topping as repeated of its name
            for _ in 1 ... value{
                toppingsName.append(key)
            }
        }
        return toppingsName
        
    }
    
    
    //MARK: - Actions
    
    
    //MARK: - delegate Handeler


    
    

}
