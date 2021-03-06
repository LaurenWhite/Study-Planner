//
//  Courses.swift
//  Study Planner
//
//  Created by Lauren White on 11/2/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import Foundation

private var courses: [Course] = CourseDatabase().loadSavedCourses()
let courseKey = "courses.key"
let genericEvents: [String] = []
let unSpecifiedCourse = Course(courseTitle: "None", events: genericEvents)

class Course{
    var courseTitle: String
    var events: Array<Any>
    
    init(courseTitle: String, events: Array<Any>){
        self.courseTitle = courseTitle
        self.events = []
    }
}



class CourseDatabase{

    //init(){
      //if(countCourses() == 0){
        //  courses.append(unSpecifiedCourse)
        //}
    //}

    //Returns: The number of notes in the database
    func countCourses() -> Int {
        return courses.count
    }
    
    //Adds the course given in parameters to array
    func addCourse(course: Course){
        courses.append(course)
        saveCourses(courses: courses)
    }
    
    //Returns the course at the given index
    func currentCourse(atIndex index: Int) -> Course {
        return courses[index]
    }
    
    //Returns the index of a course based on the title
    func courseIndexOf(title: String) -> Int {
        if let i = courses.index(where: { $0.courseTitle == title}){
            return i
        }else{
            return  0
        }
    }
    
    func saveCourses(courses: [Course]) {
        var data: [[String:Any]] = []
        //print("TITLES OF TASKS BEING SAVED:")     //print statement for tracking data persistence
        for course in courses {
            //print(task.taskTitle)     //print statement for tracking data persistence
            let courseData: [String:Any] = ["courseTitle" : course.courseTitle, "events" : course.events]
            data.append(courseData)
        }
        UserDefaults.standard.set(data, forKey: courseKey)
    }
    
    func loadSavedCourses() -> [Course] {
        let savedData = UserDefaults.standard.array(forKey: courseKey) as? [[String:AnyObject]] ?? []
        var array: [Course] = [unSpecifiedCourse]
        //var i = 0; print("TITLES OF COURSES BEING LOADED FROM PAST DATA:")     //print statement for tracking data persistence
        for courseData in savedData {
            if let courseTitle = courseData["courseTitle"] as? String,
                let events = courseData["events"] as? Array<Any> {
                array.append(Course(courseTitle: courseTitle, events: events))
                //print(array[i].courseTitle); i+= 1      //print statement for tracking data persistence
            }
        }
        return array
    }
    
}
