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
        
        self.tableView.headerViewForSection(25)
        
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
        let cTPOGvc = ChooseTypeOfGoalViewController(nibName: "ChooseTypeOfGoalViewController", bundle: nil)
        self.navigationController?.pushViewController(cTPOGvc, animated: true)

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //tell the tableView to look at GoalTableViewCell
        let cellIdentifier = "GoalTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GoalTableViewCell
        
        //Link it to your GoalModelController
        
        
        if indexPath.section == 0 {
            
//            let ind = nthIncompleteGoal(indexPath.row)
            let specificGoal = goalList[indexOfGoal(indexPath)!]
            
                //Set the text, author, pagesPerDay, and currentPage of the label
                cell.titleLabel.text = specificGoal.title
                cell.authorLabel.text = ("By: \(specificGoal.author!)")
                cell.ppdLabel.text = String(specificGoal.pagesPerDay!)
                print("PagesPerDay: \(String(specificGoal.pagesPerDay!))")
                cell.currentPageLabel.text = ("\(String(specificGoal.currentPage!)) / \(String(specificGoal.totalPages!))")
                cell.daysLeftLabel.text = String(specificGoal.completionTime!)
            
       
            
        } else if indexPath.section == 1 {
            
            let goal = goalList[indexOfGoal(indexPath)!]

            print("Rendered complete goal")
            cell.titleLabel.text = goal.title
            cell.authorLabel.text = ("By: \(goal.author!)")
            cell.ppdLabel.text = String(goal.pagesPerDay!)
            print("PagesPerDay: \(String(goal.pagesPerDay!))")
            cell.currentPageLabel.text = ("\(String(goal.currentPage!)) / \(String(goal.totalPages!))")
            cell.daysLeftLabel.text = String(goal.completionTime!)
            cell.backgroundColor = UIColor.init(red: 121.0/255.0, green: 174.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        }
        return cell
        
        
    }
    
    //Do something when table cell is clicked
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //instntiate vc
        let updateGoalViewController = UpdateGoalViewController(nibName: "UpdateGoalViewController", bundle: nil)
        
        //set whatever attribute
        updateGoalViewController.goal = goalList[indexOfGoal(indexPath)!]
        self.navigationController?.pushViewController(updateGoalViewController, animated: true)

    }
    
    //Number of rows displayed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countPerSection: Int?
        
        if section == 0 {
            countPerSection = goalList.count - getCountOfCompletedGoals()
        } else if section == 1 {
            countPerSection = getCountOfCompletedGoals()
        }
        return countPerSection!
    }
    //Get number of completed goals
    func getCountOfCompletedGoals() -> Int {
        var count = 0
        for goal in goalList {
            if goal.completed {
                count = count + 1
            }
        }
        return count
    }
    
    //Height of table cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.5
    }
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        var heightOfFooter: CGFloat
//        if section == 0 {
//            heightOfFooter = 30.0
//        } else  {
//            heightOfFooter = 30.0
//        }
//        return heightOfFooter
//    }
    
    //Swipe To Delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            //Remove from Goalist at specfic section
            goalList.removeAtIndex(indexOfGoal(indexPath)!)
            
            
            //remove cell from Table View
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //Resave goallist in NSArray to persist the deletion
            PersistenceManager.saveNSArray(goalList, fileName: "goalsCreated")
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func indexOfGoal(indexPath:NSIndexPath) -> Int? {
        if (indexPath.section == 0) {
            return nthIncompleteGoal(indexPath.row)
        }   else{
            return nthCompleteGoal(indexPath.row)
        }
    }
    
    func nthIncompleteGoal(n:Int) -> Int?  {
        
        var completedGoalsFoundCount = 0
        for (ind,goal) in goalList.enumerate()  {
            if (!goal.completed)   {
                
                if (n == completedGoalsFoundCount)   {
                    return ind
                }
                completedGoalsFoundCount += 1
            }
            print("inCompletedGoalsFoundCount: \(completedGoalsFoundCount))")
        }
        return nil

    }
    
    func nthCompleteGoal(n:Int) -> Int?  {
        
        var completedGoalsFoundCount = 0
        for (ind,goal) in goalList.enumerate()  {
            if (goal.completed)   {
                
                if (n == completedGoalsFoundCount)   {
                    return ind
                }
                completedGoalsFoundCount += 1
            }
            print("CompletedGoalsFoundCount: \(completedGoalsFoundCount))")
        }
        return nil
    }
    
    //Second Section of TableView 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String?
        if section == 0 {
            header = "Goals:"
        } else if section == 1 {
            header = "Goals Completed:"
        }
        return header
    }
    
    //Move completed goal to the new Section
    func tableView(tableView: UITableView,moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        
    }
    

}
