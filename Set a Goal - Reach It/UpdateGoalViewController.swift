//
//  UpdateGoalViewController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/22/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class UpdateGoalViewController: UIViewController {
    @IBOutlet weak var currentPageLabel: UILabel!
    @IBOutlet weak var pagesPerDayLabel: UILabel!
    @IBOutlet weak var newPagesReadTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //currentPageLabel.text = the specfic goals pressed current page.
        //pagesPerDayLabel.text = the specific goal pressed ppd
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButtonTapped(sender: UIButton) {
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
