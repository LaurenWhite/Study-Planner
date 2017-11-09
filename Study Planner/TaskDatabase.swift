//
//  TaskDatabase.swift
//  Study Planner
//
//  Created by Lauren White on 10/17/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import Foundation
private var tasks: [Task] = TaskDatabase().loadSavedTasks()
let taskKey = "tasks.key"


class TaskDatabase {
    
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
    
    //Reorders all existing notes after an edit
    func updateExisting(task: Task){
        reorder()
    }
    
    func removeTask(int: Int){
        tasks.remove(at: int)
        reorder()
    }
    
    private func reorder(){
        tasks.sort(by: { $0.dueDate < $1.dueDate })
        saveTasks(tasks: tasks)
    }
    
    func saveTasks(tasks: [Task]) {
        var data: [[String:Any]] = []
        //print("TITLES OF TASKS BEING SAVED:")     //print statement for tracking data persistence
        for task in tasks {
            //print(task.taskTitle)     //print statement for tracking data persistence
            let taskData: [String:Any] = ["taskTitle" : task.taskTitle, "completion" : task.completion, "dueDate" : task.dueDate, "courseClassification" : task.courseClassification.courseTitle]
            data.append(taskData)
        }
        UserDefaults.standard.set(data, forKey: taskKey)
    }
    
    func loadSavedTasks() -> [Task] {
        let savedData = UserDefaults.standard.array(forKey: taskKey) as? [[String:Any]] ?? []
        var array: [Task] = []
        //var i = 0; print("TITLES OF TASKS BEING LOADED FROM PAST DATA:")     //print statement for tracking data persistence
        for taskData in savedData {
            if let taskTitle = taskData["taskTitle"] as? String,
                let completion = taskData["completion"] as? Bool,
                let dueDate = taskData["dueDate"] as? Date,
                let courseClassificationTitle = taskData["courseClassification"] as? String {
                let courseClassification = CourseDatabase().currentCourse(atIndex: CourseDatabase().courseIndexOf(title: courseClassificationTitle))
                array.append(Task(taskTitle: taskTitle, completion: completion, dueDate: dueDate, courseClassification: courseClassification))
                //print(array[i].taskTitle); i+= 1      //print statement for tracking data persistence
            }
        }
        return array
    }
}

