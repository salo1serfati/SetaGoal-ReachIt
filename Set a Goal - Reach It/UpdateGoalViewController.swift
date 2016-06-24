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
    @IBOutlet weak var daysLeftLabel: UILabel!
    
    var goal:GoalModel = GoalModel()
    let blueBackground = BlueBClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "UPDATE"
        self.title = "UPDATE"
        let range = (text as NSString).rangeOfString(title!)
        let attributedString = NSMutableAttributedString(string:title!)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor() , range: range)
       
        
        titleTextField.text = "\(goal.title!)"
        currentPageLabel.text = "\(String(goal.currentPage!))/\(String(goal.totalPages!))"
        pagesPerDayLabel.text = String(goal.pagesPerDay!)
        daysLeftLabel.text = String(goal.completionTime!)
        
        //Set the gradient background color
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = blueBackground.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
        //Create place to where to tapp to make keyboard disappear
        let tgr = UITapGestureRecognizer(target: self, action: Selector("backgroundTouched"))
        self.view.addGestureRecognizer(tgr)
    }
    
    //Make keyboard disappear
    func backgroundTouched() {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        //Making the Navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 100.0/255.0, green: 179.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
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
            //Making Alert
            let alert = UIAlertController(title: "Alert", message: "Please enter how many pages have been read", preferredStyle: .Alert)
            
            let alertActionOk = UIAlertAction(title: "OK", style: .Default, handler: {action in
            })
            alert.addAction(alertActionOk)
            presentViewController(alert, animated: true, completion: nil)
        } else {
            GoalModelController.sharedInstance.updateGoal(goal, newPagesRead: makeTextFieldAnInt!)
            currentPageLabel.text = "\(String(goal.currentPage!))/\(String(goal.totalPages!))"
            pagesPerDayLabel.text = String(goal.pagesPerDay!)
            
            //Making Alert
            let alert = UIAlertController(title: "Alert", message: "Your goal has been updated", preferredStyle: .Alert)
            
            let alertActionOk = UIAlertAction(title: "OK", style: .Default, handler: {action in
            })
            alert.addAction(alertActionOk)
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

}

class BlueBClass {
    let colorTop = UIColor(red: 100.0/255.0, green: 179.0/255.0, blue: 223.0/255.0, alpha: 1.0).CGColor
    let colorBottom = UIColor(red: 23.0/255.0, green: 87.0/255.0, blue: 120.0/255.0, alpha: 1.0).CGColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}
