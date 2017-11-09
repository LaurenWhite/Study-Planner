//
//  TaskEditorViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/19/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class TaskEditorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var task : Task?
    var saveNotification: ((Task) -> Void)?
    let courseDatabase = CourseDatabase(); let taskDatabase = TaskDatabase()
    
    @IBOutlet weak var nameTextField: UITextField! //Round Text Field for Task Name
    @IBOutlet weak var dueDatePicker: UIDatePicker!  //Due Date Picker
    @IBOutlet weak var naviTitle: UINavigationItem!     //Navigation Title Label
    @IBOutlet weak var rightButton: UIBarButtonItem!    //Navigation Right Button (Add/Save)
    @IBOutlet weak var coursePicker: UIPickerView!      //Picker to choose a course
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatePicker()
        configureCoursePicker()
        
        if let task = self.task {
            configureUI(newtask: false)
            self.title = task.taskTitle
            nameTextField.text = task.taskTitle
            dueDatePicker.date = task.dueDate
            print(courseDatabase.courseIndexOf(title: task.courseClassification.courseTitle))
            coursePicker.selectRow(courseDatabase.courseIndexOf(title: task.courseClassification.courseTitle), inComponent: 0, animated: true)
        }else{
            configureUI(newtask: true)
            nameTextField.text = ""
        }
    }
    
    //Changes right button to Add/Save & title depending on if the note is new or existing
    func configureUI(newtask: Bool){
        if(newtask){
            naviTitle.title = "Create New Task"
            rightButton.title = "Add"
        }else{
            naviTitle.title = "Edit Task"
            rightButton.title = "Save"
        }
    }

    //Sets minimum and maximum restrictions for the due date
    func configureDatePicker(){
        let calendar = Calendar.current
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        maxDateComponent.year = 2021
        let maxDate = calendar.date(from: maxDateComponent)
        
        dueDatePicker.maximumDate =  maxDate! as Date
        dueDatePicker.minimumDate = Date()
        
    }
    
    //Sets data source and delegate of picker to self
    func configureCoursePicker(){
        self.coursePicker.delegate = self
        self.coursePicker.dataSource = self
    }
    
    //User clicked "Add" button on the Task Editor Page
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newTitle: String
        if(SettingsViewController().isValidName(enteredName: self.nameTextField.text!)){
            newTitle = self.nameTextField.text!
        }else{
            newTitle = "New Task"
        }
        let newDueDate = dueDatePicker.date
        let newCourse = courseDatabase.currentCourse(atIndex: coursePicker.selectedRow(inComponent: 0))
        if let task = self.task {
            task.taskTitle = newTitle
            task.dueDate = newDueDate
            task.courseClassification = newCourse
            
            TaskDatabase().updateExisting(task: task)
        } else {
            let newTask = Task(taskTitle: newTitle, completion: false, dueDate: newDueDate, courseClassification: newCourse)
            self.saveNotification?(newTask)
        }
        // Go back to the list of notes
        self.performSegue(withIdentifier: "TaskAdded", sender: nil)
    }
    
    //Returns number of components desired in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Returns number of courses in array to the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courseDatabase.countCourses()
    }
    
    //Sets the picker item title to the corresponding course array title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let course = courseDatabase.currentCourse(atIndex: row)
        return course.courseTitle
    }
    
}
