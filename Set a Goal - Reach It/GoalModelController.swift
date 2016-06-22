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
        return goalList
        
    }
    
    //calculates the pages needed to be read per day AT THE START OF THE GOAL
    func checkPagesPerDay(totalPages:Int, completionTime:Int) -> Int {
        let totalPages = totalPages
        let completionTime = completionTime
        let pagesPerDay = totalPages / completionTime
        
        return pagesPerDay
    
    }
    
    //Updates goal when new number of pages is inserted. 
    func updateGoal(goal:GoalModel, newPagesRead: Int) {
        let totalPages = goal.totalPages
        let completionTime = goal.completionTime
        var currentPage = goal.currentPage
        let currentDate = NSDate()
        let daysPassed = NSCalendar(calendarIdentifier: "..")?.daysWithinEraFromDate(goal.dateCreated!, currentDate: currentDate)
        
        //Update the Current Page
        currentPage = newPagesRead + currentPage!
        
        //Calculating the pages and days left after the update
        let pagesLeft = totalPages! - currentPage!
        let daysLeft = completionTime! - daysPassed!
        //So you could now calculate Pages Per Day...
        let pagesPerDay = pagesLeft / daysLeft
        
        //Now set the new Pages Per Day to the Goal Object
        goal.pagesPerDay = pagesPerDay
    
        //Also set the new Current Page
        goal.currentPage = currentPage
    }
    
}

extension NSCalendar {
    func daysWithinEraFromDate(startDate: NSDate, currentDate: NSDate) -> Int {
        let startDay = self.ordinalityOfUnit(.Day, inUnit: NSCalendarUnit.Era, forDate: startDate)
        let endDay = self.ordinalityOfUnit(.Day, inUnit: NSCalendarUnit.Era, forDate: currentDate)
        return endDay - startDay
    }
}