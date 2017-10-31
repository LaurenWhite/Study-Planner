//
//  TaskDetalisViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/19/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class TaskDetalisViewController: UIViewController {

    var task: Task?
    //var sendExistingTask: ((Task)->Void)?
    
    //UI PROPERTIES
    @IBOutlet weak var taskDetailsTitleLabel: UILabel!
    @IBOutlet weak var dateDueLabel: UILabel!
    @IBOutlet weak var taskCompleteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        if let task = self.task {
            self.title = task.taskTitle
            taskDetailsTitleLabel.text = task.taskTitle
            taskCompleteSwitch.isOn = task.completion
        }
        
        if let date: Date = task?.dueDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let dueDateValue = dateFormatter.string(from: date)
            dateDueLabel.text = dueDateValue
        }
        
    }
    
    //User pressed the edit button on the Task Details Page
    @IBAction func editTaskButtonPressed(_ sender: UIBarButtonItem) {
        // HOW CAN YOU PASS THE CURRENT TASK TO THE TASK EDITOR FROM HERE?
        //self.sendExistingTask?(task!) //<- did not work :(
        let existingTask = self.task
        let TaskEditorVC = TaskEditorViewController()
        TaskEditorVC.task = existingTask
        self.performSegue(withIdentifier: "EditTask", sender: nil)
    }
    
    //User switched the "Mark Task as Completed" Switch
    @IBAction func taskCompleteSwitched(_ sender: UISwitch) {
        if(taskCompleteSwitch.isOn){
            task?.completion = true
            self.performSegue(withIdentifier: "BackToDailyToDo", sender: nil)
        }else{
            task?.completion = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let existingTask = self.task
        if let TaskEditorViewController = segue.destination as? TaskEditorViewController{
            TaskEditorViewController.task = existingTask
        }
    }
    
}
