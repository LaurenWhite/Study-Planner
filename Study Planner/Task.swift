//
//  Task.swift
//  Study Planner
//
//  Created by Lauren White on 10/17/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import Foundation

class Task {
    var taskTitle: String
    var completion: Bool
    var dueDate: Date
    var courseClassification: Course
    
    init(taskTitle: String, completion: Bool, dueDate: Date, courseClassification: Course){
        self.taskTitle = taskTitle
        self.completion = false
        self.dueDate = dueDate
        self.courseClassification = courseClassification
    }
    
}
