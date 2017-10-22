//
//  TaskDatabase.swift
//  Study Planner
//
//  Created by Lauren White on 10/17/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import Foundation
private var tasks: [Task] = []

class TaskDatabase {
    
    
    /*init() { // 3
        // Create some data to work with initially
        var currentIndex: Int = tasks.index(after: (tasks.count))
        saveNew(task: Task(taskTitle: String(currentIndex) + ". Read Assigned", completion: false, dueDate: Date()))
        currentIndex = tasks.index(after: (tasks.count))
        saveNew(task: Task(taskTitle: String(currentIndex) + ". Study for Calc Test", completion: true, dueDate: Date()))
    }*/
    
    //Returns: The number of notes in the database
    var countTasks: Int {
        return tasks.count
    }
    
    //Returns: The task at the given index
    func currentTask(atIndex index: Int) -> Task {
        return tasks[index]
    }
    
    //Saves the note to the database
    func saveNew(task: Task){
        tasks.append(task)
        reorder()
    }
    
    private func reorder(){
        tasks.sort(by: { $0.dueDate < $1.dueDate })
    }
}
