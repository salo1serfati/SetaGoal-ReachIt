//
//  BeniGameViewController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 7/10/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class BeniGameViewController: UIViewController {
    var tagCount = 0
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    
 

    @IBOutlet weak var tryAgainLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var beniFacedTapped: UIButton!
    @IBOutlet weak var SaloButton: UIButton!
    @IBOutlet weak var AviButton: UIButton!
    @IBOutlet weak var KipsButton: UIButton!
    @IBOutlet weak var JuliButton: UIButton!
    @IBOutlet weak var AaronButton: UIButton!
    @IBOutlet weak var AlbertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Timing Stuff
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Hide Buttons
        backButton.hidden = true
        
        SaloButton.hidden = true
        AviButton.hidden = true
        KipsButton.hidden = true
        JuliButton.hidden = true
        AaronButton.hidden = true
        AlbertButton.hidden = true
    
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func backButtonTapped(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func beniFaceTapped(sender: UIButton) {
        
        SaloButton.hidden = false
        beniFacedTapped.hidden = true
        KipsButton.hidden = false
        
//        tagCount = sender.tag
//        sender.tag = sender.tag + 1
//
//        beniFacedTapped.frame = CGRect(x: Int(arc4random_uniform(375)), y: Int(arc4random_uniform(667)), width: 156, height: 142)
//    
//        if sender.tag == 9 {
//            beniFacedTapped.hidden = true
//            backButton.hidden = false
//            timer.invalidate()
//            //timer == nil
//        
//            
//        }
        
    }
    
    @IBAction func saloFaceTapped(sender: UIButton) {
        SaloButton.hidden = true
        AaronButton.hidden = false
        AviButton.hidden = true
        AlbertButton.hidden = true
    }
    

    @IBAction func aaronFaceTapped(sender: UIButton) {
        SaloButton.hidden = true
        AaronButton.hidden = true
        KipsButton.hidden = false
        beniFacedTapped.hidden = false
        AlbertButton.hidden = true

    }
    
  
    @IBAction func kipsFaceTapped(sender: UIButton) {
        KipsButton.hidden = true
        AlbertButton.hidden = false
        AviButton.hidden = false
    }

    @IBAction func albertFaceTapped(sender: UIButton) {
        AlbertButton.hidden = true
        JuliButton.hidden = false
        KipsButton.hidden = true
    }
    
    @IBAction func juliFaceTapped(sender: UIButton) {
        timer.invalidate()
        tryAgainLabel.text = "Hahahaha You Found it!"
        backButton.hidden = false
        
        JuliButton.hidden = true
        SaloButton.hidden = true
        AviButton.hidden = true
        KipsButton.hidden = true
        AlbertButton.hidden = true
        beniFacedTapped.hidden = true
        AaronButton.hidden = true
        
    }
    
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        timeLabel.text = "\(strSeconds):\(strFraction) "
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
