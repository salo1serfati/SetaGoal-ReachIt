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
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 95.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //navigationController?.navigationBar.titleTextAttributes =
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
       
        //Make sure you create Checks so the app doesnt crash if something is not inputted or if a string is placed where an Int should be
        GoalModelController.sharedInstance.createNewGoal(title!, author: author!, totalPages: totalPages!, completionTime: completionTime!)
        
        print("New Goal Created")
        
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
