//
//  EasterEggViewController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 7/5/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class EasterEggViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameTapped(sender: UIButton) {
        let beniGameViewController = BeniGameViewController(nibName: "BeniGameViewController", bundle: nil)
        navigationController?.pushViewController(beniGameViewController, animated: true)

        
    }
    @IBAction func returnButtonTapped(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToTableView()
        
    }

    @IBAction func infoButtonTapped(sender: UIButton) {
        //Making Alert
        let alert = UIAlertController(title: "Info", message: "Tapp as many Beni's as you can as quickly as possible. The goal of this game is to always have a higher score than Beni. Enjoy dudes", preferredStyle: .Alert)
        
        let alertActionOk = UIAlertAction(title: "OK", style: .Default, handler: {action in
        })
        alert.addAction(alertActionOk)
        presentViewController(alert, animated: true, completion: nil)

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
