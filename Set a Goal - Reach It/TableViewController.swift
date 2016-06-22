//
//  TableViewController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/20/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var goalList: [GoalModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set the goalList to the same on as your Model Controller
        goalList = GoalModelController.sharedInstance.getGoalList()
        
        //Set the delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //Register the Nib
        tableView.registerNib(UINib(nibName: "GoalTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalTableViewCell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //Get goalist and reload data 
        goalList = GoalModelController.sharedInstance.getGoalList()
        tableView.reloadData()
        print("GoalList (view will appear): \(GoalModelController.sharedInstance.getGoalList()))")
        
        navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func newGoalButtonTapped(sender: UIButton) {
        let nGvc = NewGoalViewController(nibName: "NewGoalViewController", bundle: nil)
        self.navigationController?.pushViewController(nGvc, animated: true)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //tell the tableView to look at GoalTableViewCell
        let cellIdentifier = "GoalTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GoalTableViewCell
        
        //Link it to your GoalModelController
        let specificGoal = goalList[indexPath.row]
        
        //Set the text, author, pagesPerDay, and currentPage of the label
        cell.titleLabel.text = specificGoal.title
        cell.authorLabel.text = specificGoal.author
        cell.ppdLabel.text = String(specificGoal.pagesPerDay!)
        cell.currentPageLabel.text = String(specificGoal.currentPage!)
        
        return cell
        
    }
    
    //Do something when table cell is clicked
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //Number of rows displayed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalList.count
    }
    
    //Height of table cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.5
    }
    
    //Swipe To Delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            goalList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    
    

}
