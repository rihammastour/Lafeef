//
//  GameInstructionViewController.swift
//  Lafeef
//
//  Created by Mihaf on 21/08/1442 AH.
//

import UIKit

class GameInstructionViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var slides:[Slide] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        self.slides = createSlides()
        setupSlideScrollView(slides: slides)
        print(slides.count)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        self.scrollView.contentSize.height = 1.0

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    func createSlides() -> [Slide] {

            let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide1.slideImage.image = UIImage(named: "gifts")
            slide1.slideLabel.text = "A real-life bear"
         
            
            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide2.slideImage.image = UIImage(named: "adv2")
            slide2.slideLabel.text = "A real-life bear"
      
            
            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide3.slideImage.image = UIImage(named: "adv1")
            slide3.slideLabel.text = "A real-life bear"
       
            
            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide4.slideImage.image = UIImage(named: "cake")
            slide4.slideLabel.text = "A real-life bear"
     
            
            
//            let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide5.slideImage.image = UIImage(named: "boy")
//            slide5.slideLabel.text = "A real-life bear"
      
            
            return [slide1, slide2, slide3, slide4]
        }
    
    func setupSlideScrollView(slides : [Slide]) {
         scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
         scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
         scrollView.isPagingEnabled = true
         
         for i in 0 ..< slides.count {
             slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
             scrollView.addSubview(slides[i])
         }
     }
    /*
        * default function called when view is scolled. In order to enable callback
        * when scrollview is scrolled, the below code needs to be called:
        * slideScrollView.delegate = self or
        */
//       func scrollViewDidScroll(_ scrollView: UIScrollView) {
//           let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
//           pageControl.currentPage = Int(pageIndex)
//           
//           let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
//           let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
//           
//           // vertical
//           let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
//           let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
//           
//           let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
//           let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
//           
//           
//           /*
//            * below code changes the background color of view on paging the scrollview
//            */
//   //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
//           
//       
//           /*
//            * below code scales the imageview on paging the scrollview
//            */
//           let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
//           
//           if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//               
//               slides[0].slideImage.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//               slides[1].slideImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//               
//           } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//               slides[1].slideImage.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//               slides[2].slideImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//               
//           } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//               slides[2].slideImage.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//               slides[3].slideImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//               
//           } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//               slides[3].slideImage.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//               
//           }
//       }
//    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
//           if(pageControl.currentPage == 0) {
//               //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
//               //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
//               //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
//
////               let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//               pageControl.pageIndicatorTintColor = pageUnselectedColor
//
////
////               let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//               slides[pageControl.currentPage].backgroundColor = bgColor
//
//               let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//               pageControl.currentPageIndicatorTintColor = pageSelectedColor
//           }
//       }

//    func fade(fromRed: CGFloat,
//                fromGreen: CGFloat,
//                fromBlue: CGFloat,
//                fromAlpha: CGFloat,
//                toRed: CGFloat,
//                toGreen: CGFloat,
//                toBlue: CGFloat,
//                toAlpha: CGFloat,
//                withPercentage percentage: CGFloat) -> UIColor {
//
//          let red: CGFloat = (toRed - fromRed) * percentage + fromRed
//          let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
//          let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
//          let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
//
//          // return the fade colour
//          return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//      }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         /*
          *
          */
        setupSlideScrollView(slides: slides)
    }


}
