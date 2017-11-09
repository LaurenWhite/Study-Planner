//
//  SettingsViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/31/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    let courseDatabase = CourseDatabase()
    
    
    @IBOutlet weak var courseNameTextField: UITextField!    //Round Text Field next to Add a Course
    @IBOutlet var courseListOfLabels: [UILabel]!        //Collection of labels, displays added course
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCourseList()
        
        self.courseNameTextField.delegate = self
    }
    
    //Shows the saved courses in the label collection
    func showCourseList(){
        var labelIndex = 0
        for label in courseListOfLabels{
            if (labelIndex > courseDatabase.countCourses()-1){
                label.text = ""
            }else{
                let labelTitle = courseDatabase.currentCourse(atIndex: labelIndex+1).courseTitle
                if (labelTitle != "None"){
                    label.text = "\(labelIndex+1). \(labelTitle)"
                }
            }
            labelIndex += 1
        }
    }
    
    //User touched Return on the keyboard in the Course Name Text Field
    //Adds text as course name and resets or gives invalid course
    @IBAction func returnPressed(_ sender: UITextField) {
        let newCourseTitle = courseNameTextField.text
        if isValidName(enteredName: newCourseTitle!){
            let newCourseEvents: [String] = []
            let newCourse = Course(courseTitle: newCourseTitle!, events: newCourseEvents)
            courseDatabase.addCourse(course: newCourse)
            addCourseToLabel(labelTitle: newCourse.courseTitle)
        }else{
            let invalidNameAlert = UIAlertController(title: "Invalid Course Name", message: "Enter a course name", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Ok", style: .default)
            invalidNameAlert.addAction(confirm)
            self.present(invalidNameAlert, animated: true)
        }
        courseNameTextField.text = ""
    }
    
    //Adds the course the user typed into the text field to the label collection
    func addCourseToLabel(labelTitle: String){
        let index = (courseDatabase.countCourses())-1
        courseListOfLabels[index].text = "\(index+1). \(labelTitle)"
    }
    
    //Checks if the entered title is not solely whitespaces
    func isValidName(enteredName: String) -> Bool{
        var valid = false
        let trimmedName = enteredName.trimmingCharacters(in: .whitespacesAndNewlines)
        if  !trimmedName.isEmpty{
            valid = true
        }
        return valid
    }

}
