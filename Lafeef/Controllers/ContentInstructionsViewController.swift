//
//  ContentInstructionsViewController.swift
//  Lafeef
//
//  Created by Renad nasser on 21/04/2021.
//

import UIKit
import AVKit

class ContentInstructionsViewController: UIViewController {

    var displayText:String?
    var index:Int?
    var videoName:String?
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVedio()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer?.play()
        print("viewDidAppear",displayText)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // setUpVedio()
        print("viewWillAppear",displayText)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer?.pause()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)


    }
    // MARK: - Navigation

    func setUpVedio(){
        //Get the pathto the resource in the bundle
       let bundlePath =  Bundle.main.path(forResource: displayText, ofType: "mov")// Optinal
        
        guard bundlePath != nil else{
            return
        }
        
        //create URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        
        //create the vedio player items
        let item = AVPlayerItem(url: url)
        //create the player
        videoPlayer = AVPlayer(playerItem: item)
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: 525, height: 686)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.play()
    }

}
