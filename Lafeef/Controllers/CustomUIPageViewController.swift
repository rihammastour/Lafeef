//
//  CustomUIPageViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 21/04/2021.
//

import UIKit

class CustomUIPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let pageController = UIPageControl.appearance()
        pageController.currentPageIndicatorTintColor = UIColor(named: "blueApp")
        pageController.pageIndicatorTintColor =  .lightGray
        // Do any additional setup after loading the view.
    }
    

}
