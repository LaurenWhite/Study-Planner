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
    
    
    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBOutlet var courseListOfLabels: [UILabel]!
    
    @IBAction func returnPressed(_ sender: UITextField) {
        if let newCourseTitle = courseNameTextField.text{
            let newCourseEvents: [String] = []
            let newCourse = Course(courseTitle: newCourseTitle, events: newCourseEvents)
            courseDatabase.addCourse(course: newCourse)
            addCourseToLabel(labelTitle: newCourse.courseTitle)
        }
        courseNameTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for label in courseListOfLabels{
            if (index(ofAccessibilityElement: label) > courseDatabase.countCourses()-1){
                label.text = ""
            }
        }
        self.courseNameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func addCourseToLabel(labelTitle: String){
        let index = (courseDatabase.countCourses())-1
        courseListOfLabels[index].text = "\(index+1). \(labelTitle)"
        
    }

}
