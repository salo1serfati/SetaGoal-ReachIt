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
        newGoal.ID = NSUUID().UUIDString
        print("New Goal Created and the ID is: \(newGoal.ID))")
        goalList.append(newGoal)
        print("Goalist after Append: \(goalList)")
        
        PersistenceManager.saveNSArray(goalList, fileName: "goalsCreated")
    }
    
    //gets goals from goalList
    func getGoalList()->[GoalModel] {
        let result = PersistenceManager.loadNSArray("goalsCreated")
        let places = result as? [GoalModel]
        
        if places == nil {
            self.goalList += []
        } else {
            self.goalList = places!
        }
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
        var completed = goal.completed
        print("currentDate: \(currentDate)")
        print("Start Date \(goal.dateCreated)")
        
        //calculating daysPassed
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDayForDate(goal.dateCreated!)
        let date2 = calendar.startOfDayForDate(currentDate)
        
        let flags = NSCalendarUnit.Day
        let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
        
          // This will return the number of day(s) between dates
        let daysPassed = components.day
        print("Days Passed \(daysPassed)")
        
        //Update the Current Page
        currentPage = newPagesRead + currentPage!
        
        //Calculating the pages and days left after the update
        let pagesLeft = totalPages! - currentPage!
        let daysLeft = completionTime! - daysPassed
        //So you could now calculate Pages Per Day...
        let pagesPerDay = pagesLeft / daysLeft
        
        if currentPage <= totalPages {
        
        //Now set the new Pages Per Day to the Goal Object
        goal.pagesPerDay = pagesPerDay
    
        //Also set the new Current Page
        goal.currentPage = currentPage
        print("Your goal has been updated")
            if currentPage == totalPages {
                completed = true
                print("You Finished Your Goal!")
            }
        
        } else {
            print("You read more pages than are in your book!")
            return
        }
        
        
        for (i,goalInArray) in goalList.enumerate() {
            print("GoalInArray ID: \(goalInArray.ID)")
            print("Goal ID: \(goal.ID)")
            if (goalInArray.ID  == goal.ID) {
                goalList.removeAtIndex(i)
                print("GoalList after Removal:\(goalList)")
                goalList.append(goal)
            }
        }
        
          
        
        PersistenceManager.saveNSArray(goalList, fileName: "goalsCreated")
    }
    
}


class PersistenceManager {
    
    //Gets you the writing document directory path
    class private func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory
    }
    
    class func loadObject(filename:String) -> NSObject? {
        let file = documentsDirectory().stringByAppendingPathComponent(filename)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSObject
    }
    
    class func saveObject(objectToSave: NSObject, fileName: String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(objectToSave, toFile: file)
    }
    
    class func saveNSArray(arrayToSave: NSArray, fileName:String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: file)
    }
    
    class func loadNSArray(fileName:String) -> NSArray? {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSArray
    }
}
