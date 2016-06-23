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
        if indexPath.section == 0 {
        //Set the text, author, pagesPerDay, and currentPage of the label
        cell.titleLabel.text = specificGoal.title
        cell.authorLabel.text = ("By: \(specificGoal.author!)")
        cell.ppdLabel.text = String(specificGoal.pagesPerDay!)
        print("PagesPerDay: \(String(specificGoal.pagesPerDay!))")
        cell.currentPageLabel.text = ("\(String(specificGoal.currentPage!)) / \(String(specificGoal.totalPages!))")
        cell.daysLeftLabel.text = String(specificGoal.completionTime!)
            
        } else if indexPath.section == 1 {
            for goal in goalList {
                if goal.completed {
                    print("Rendered complete goal")
                    cell.titleLabel.text = goal.title
                    cell.authorLabel.text = ("By: \(goal.author!)")
                    cell.ppdLabel.text = String(goal.pagesPerDay!)
                    print("PagesPerDay: \(String(goal.pagesPerDay!))")
                    cell.currentPageLabel.text = ("\(String(goal.currentPage!)) / \(String(goal.totalPages!))")
                    cell.daysLeftLabel.text = String(goal.completionTime!)
                }
            }
        }
        return cell
        
    }
    
    //Do something when table cell is clicked
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //instntiate vc
        let updateGoalViewController = UpdateGoalViewController(nibName: "UpdateGoalViewController", bundle: nil)
        
        //set whatever attribute
        updateGoalViewController.goal = goalList[indexPath.row]
        self.navigationController?.pushViewController(updateGoalViewController, animated: true)

    }
    
    //Number of rows displayed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countPerSection: Int?
        
        if section == 0 {
            countPerSection = goalList.count
        } else if section == 1 {
            countPerSection = 1
        }
        return countPerSection!
    }
    
    //Height of table cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.5
    }
    
    //Swipe To Delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //remove item from goalList
            goalList.removeAtIndex(indexPath.row)
            
            //remove cell from Table View
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //Resave goallist in NSArray to persist the deletion
            PersistenceManager.saveNSArray(goalList, fileName: "goalsCreated")
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //Second Section of TableView 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String?
        if section == 0 {
            header = "Goals"
        } else if section == 1 {
            header = "Goals Completed"
        }
        return header
    }
    
    //Move completed goal to the new Section
    func tableView(tableView: UITableView,moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        
    }
    

}
