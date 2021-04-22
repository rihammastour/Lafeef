//
//  InstructionsViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 21/04/2021.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var continerView: UIView!
    
    let dataSource = ["serveOrder","2"]
    var currentViewControllerIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        continerView.layer.cornerRadius = 40

        configurePageViewController()
    }
    
    // MARK: - Functions
    
    func configurePageViewController(){
        
        guard let pageViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.CustomPageViewController) as? CustomUIPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.view.backgroundColor = UIColor(named: "bachgroundApp")
        
        contentView.addSubview(pageViewController.view)
        let views:[String:Any] = ["pageView":pageViewController.view]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue:0), metrics: nil, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue:0), metrics: nil, views: views))
        
        

        
        guard let startingViewController = viewContoller(at : currentViewControllerIndex) else {
            return
        }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
    }
    
    func viewContoller(at index:Int)->ContentInstructionsViewController?{
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let InsContentViewController = storyboard?.instantiateViewController(identifier: String(describing: ContentInstructionsViewController.self)) as? ContentInstructionsViewController else {
            return nil
        }
        InsContentViewController.index = index
        InsContentViewController.displayText = dataSource[index]
        //InsContentViewController.setUpVedio()
        
        return InsContentViewController
    }
    //MARK: - IBAction

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


//MARK: - Extenstion UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension InstructionsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let insContentViewController = viewController as? ContentInstructionsViewController

        
        guard var currentIndex = insContentViewController?.index else {
            return nil
        }
        print("currentIndex Before",currentIndex)
        currentViewControllerIndex = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return viewContoller(at: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        let insContentViewController = viewController as? ContentInstructionsViewController

        guard var currentIndex = insContentViewController?.index else {
            return nil
        }
        print("currentIndex After",currentIndex)
        currentViewControllerIndex = currentIndex
        if currentIndex == dataSource.count-1 {
            return nil
        }
        currentIndex += 1

        return viewContoller(at: currentIndex)
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
   
    
}
