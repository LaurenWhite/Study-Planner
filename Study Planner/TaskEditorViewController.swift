//
//  TaskEditorViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/19/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class TaskEditorViewController: UIViewController {

    var task : Task?
    var saveNotification: ((Task) -> Void)?
    
    @IBOutlet weak var nameTextField: UITextField! //Round Text Field for Task Name
    @IBOutlet weak var dueDatePicker: UIDatePicker!  //Due Date Picker
    @IBOutlet weak var naviTitle: UINavigationItem!     //Navigation Title Label
    @IBOutlet weak var rightButton: UIBarButtonItem!    //Navigation Right Button (Add/Save)
    
    
    
    //User clicked "Add" button on the Task Editor Page
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let newTitle = self.nameTextField.text ?? "New Task"
        let newDueDate = dueDatePicker.date
        if let task = self.task {
            task.taskTitle = newTitle
            task.dueDate = newDueDate
            TaskDatabase().updateExisting(task: task)
        } else {
            let newTask = Task(taskTitle: newTitle, completion: false, dueDate: newDueDate)
            self.saveNotification?(newTask)
        }
        
        // Go back to the list of notes
        self.performSegue(withIdentifier: "TaskAdded", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = self.task {
            configureUI(newtask: false)
            self.title = task.taskTitle
            nameTextField.text = task.taskTitle
            dueDatePicker.date = task.dueDate
        }else{
            configureUI(newtask: true)
            nameTextField.text = ""
        }
    }
    
    func configureUI(newtask: Bool){
        if(newtask){
            naviTitle.title = "Create New Task"
            rightButton.title = "Add"
        }else{
            naviTitle.title = "Edit Task"
            rightButton.title = "Save"
        }

}

}
