//
//  GoalModelController.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/20/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import Foundation


class GoalModelController:NSObject {
    //create goals array (array of objects)
    private var goalList: [GoalModel] = []
    
    // Singleton design pattern
    class var sharedInstance: GoalModelController {
        struct Static {
            static var instance:GoalModelController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = GoalModelController()
        }
        return Static.instance!
    }
 
    //function that creates a new Goal
    func createNewGoal(title:String, author:String, totalPages:Int, completionTime:Int) {
        //create new goal and append to goalList
        let newGoal = GoalModel(title: title, author: author, totalPages: totalPages, completionTime: completionTime)
        newGoal.completed = false
        newGoal.currentPage = 0
        newGoal.pagesPerDay = self.checkPagesPerDay(totalPages, completionTime: completionTime)
        newGoal.dateCreated = NSDate()
        print("\(newGoal.dateCreated)")
        goalList.append(newGoal)
        print("Goalist after Append: \(goalList)")
    }
    
    //gets goals from goalList
    func getGoalList()->[GoalModel] {
        print("goalList From func getGoalList: \(goalList)")
        return goalList
        
    }
    
    //calculates the pages needed to be read per day AT THE START OF THE GOAL
    func checkPagesPerDay(totalPages:Int, completionTime:Int) -> Int {
        let totalPages = totalPages
        let completionTime = completionTime
        let pagesPerDay = totalPages / completionTime
        
        return pagesPerDay
    
    }
    
    
    
    
}