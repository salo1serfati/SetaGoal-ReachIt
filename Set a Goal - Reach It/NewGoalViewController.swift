//
//  NewGoalViewController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/20/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class NewGoalViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var totalPagesTextField: UITextField!
    @IBOutlet weak var completionTimeTextField: UITextField!
    
    let redBackground = RedBClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the title
        self.title = "SET A GOAL"
      
        //Set the gradient background color
        view.backgroundColor = UIColor.clearColor()
        let backgroundLayer = redBackground.gl
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
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 95.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
       
        let title = titleTextField.text
        let author = authorTextField.text
        let totalPages = Int(totalPagesTextField.text!)
        let completionTime = Int(completionTimeTextField.text!)
       print("Author: \(author)")
        //Checks for nils and empty textFields
        if title == nil || title == "" {
            print("Please enter a title")
        }
        if author == nil || author == "" {
            print("Please enter an Author")
            
        }
        if totalPages == nil || totalPagesTextField.text != ""{
            print("Please enter Total Amount of Pages")
        }
        if completionTime == nil || completionTimeTextField.text != "" {
            print("Please enter Completion Time")
        }
        //If Everything is inserted.
        if title != nil && author != nil && totalPages != nil && completionTime != nil {
            GoalModelController.sharedInstance.createNewGoal(title!, author: author!, totalPages: totalPages!,  completionTime: completionTime!)
            print("New Goal Created")
            //Making Alert
            let alert = UIAlertController(title: "Alert", message: "Your goal has been created", preferredStyle: .Alert)
            
            let alertActionGoBack = UIAlertAction(title: "OK", style: .Default, handler: {action in
                let tableViewController = TableViewController(nibName: "TableViewController", bundle: nil)
                self.navigationController?.pushViewController(tableViewController, animated: true)
                 })
            alert.addAction(alertActionGoBack)
            presentViewController(alert, animated: true, completion: nil)
        }
        sender.userInteractionEnabled = false
    }
}

class RedBClass {
    let colorTop = UIColor(red: 255.0/255.0, green: 95.0/255.0, blue: 94.0/255.0, alpha: 1.0).CGColor
    let colorBottom = UIColor(red: 174.0/255.0, green: 25.0/255.0, blue: 22.0/255.0, alpha: 1.0).CGColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}
