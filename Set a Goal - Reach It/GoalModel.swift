//
//  GoalModel.swift
//  Set a Goal - Reach It
//
//  Created by Salomon serfati on 6/20/16.
//  Copyright © 2016 Salomon Serfati. All rights reserved.
//

import Foundation


class GoalModel:NSObject, NSCoding {
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
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.author, forKey: "author")
        aCoder.encodeObject(self.totalPages, forKey: "totalPages")
        aCoder.encodeObject(self.completionTime, forKey: "completionTime")
        aCoder.encodeObject(self.completed, forKey: "completed")
        aCoder.encodeObject(self.currentPage, forKey: "currentPage")
        aCoder.encodeObject(self.pagesPerDay, forKey: "pagesPerDay")
        aCoder.encodeObject(self.dateCreated, forKey: "dateCreated")
        
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObjectForKey("title") as? String
        let author = aDecoder.decodeObjectForKey("author") as? String
        let totalPages = aDecoder.decodeObjectForKey("totalPages") as? Int
        let completionTime = aDecoder.decodeObjectForKey("completionTime") as? Int
        let completed = aDecoder.decodeObjectForKey("completed") as? Bool
        let currentPage = aDecoder.decodeObjectForKey("currentPage") as? Bool
        let pagesPerDay = aDecoder.decodeObjectForKey("pagesPerDay") as? Int
        let dateCreated = aDecoder.decodeObjectForKey("dateCreated") as? NSDate

        self.init(title: title!, author: author!, totalPages: totalPages!, completionTime: completionTime!)
        
    }
}