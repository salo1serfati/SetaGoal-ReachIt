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

    @IBOutlet weak var titleTextField: UILabel!
    var goal:GoalModel = GoalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = "\(goal.title!) by: \(goal.author!)"
        currentPageLabel.text = String(goal.currentPage!)
        pagesPerDayLabel.text = String(goal.pagesPerDay!)
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButtonTapped(sender: UIButton) {
        
        let makeTextFieldAnInt = Int(newPagesReadTextField.text!)
        
        //Check that textField isnt empty
        if makeTextFieldAnInt == nil || newPagesReadTextField.text == "" {
            print("Please enter how many pages have been read")
        } else {
            currentPageLabel.text = String(goal.currentPage!)
            pagesPerDayLabel.text = String(goal.pagesPerDay!)
            GoalModelController.sharedInstance.updateGoal(goal, newPagesRead: makeTextFieldAnInt!)
            
        }
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
