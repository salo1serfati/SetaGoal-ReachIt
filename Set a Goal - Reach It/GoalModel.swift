//
//  GoalModel.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/20/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import Foundation


class GoalModel:NSObject { 
    var title: String?
    var author: String?
    var totalPages: Int?
    var completionTime: Int?
    var completed: Bool?
    var currentPage: Int?
    var pagesPerDay: Int?
    var dateCreated: NSDate?
    
    //Creating  the Object for the new Goal. Parameters are required, what is in the init is optional.
    init (title:String, author:String, totalPages:Int, completionTime:Int) {
        //Given by Parameters
        self.title = title
        self.author = author
        self.totalPages = totalPages
        self.completionTime = completionTime
        
        //Additional descriptions of Goal
        self.completed = false
        self.currentPage = 0
        self.pagesPerDay = 0
        self.dateCreated = NSDate()
        
        
    }
    
    override init() {
        
        
    }
}