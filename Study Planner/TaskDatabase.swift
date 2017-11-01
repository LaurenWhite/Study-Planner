//
//  TaskDatabase.swift
//  Study Planner
//
//  Created by Lauren White on 10/17/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import Foundation
private var tasks: [Task] = []
let taskKey = "tasks"
var first = true

class TaskDatabase {
    
    
    init() { // 3
        /*
        // Create some data to work with initially
        var currentIndex: Int = tasks.index(after: (tasks.count))
        saveNew(task: Task(taskTitle: String(currentIndex) + ". Read Assigned", completion: false, dueDate: Date()))
        currentIndex = tasks.index(after: (tasks.count))
        saveNew(task: Task(taskTitle: String(currentIndex) + ". Study for Calc Test", completion: true, dueDate: Date()))
         */
        if (first){
        tasks = addSavedTasks()
            first = false
        }
     }
    
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
        saveTasks(tasks: tasks)
    }
    
    func addSavedTasks() -> [Task]{
        let savedData = UserDefaults.standard.array(forKey: taskKey) as? [[String:AnyObject]] ?? []
        var array: [Task] = []
        for taskData in savedData {
            if let taskTitle = taskData["taskTitle"] as? String,
                let completion = taskData["completion"] as? Bool,
                let dueDate = taskData["dueDate"] as? Date {
                array.append(Task(taskTitle: taskTitle, completion: completion, dueDate: dueDate))
            }
        }
        return array
    }
    
    func saveTasks(tasks: [Task]) {
        var data: [[String:Any]] = [] // 1
        for task in tasks {
            let taskData: [String:Any] = ["taskTitle" : task.taskTitle, "completion" : task.completion, "dueDate" : task.dueDate] // 2
            data.append(taskData)
        }
        UserDefaults.standard.set(data, forKey: taskKey) // 3
    }
    
    
}
