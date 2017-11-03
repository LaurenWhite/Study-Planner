//
//  Courses.swift
//  Study Planner
//
//  Created by Lauren White on 11/2/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import Foundation

private var courses: [Course] = []//change later for persistence

class Course{
    var courseTitle: String
    var events: Array<Any>
    
    init(courseTitle: String, events: Array<Any>){
        self.courseTitle = courseTitle
        self.events = []
    }
}

class CourseDatabase{
    
    //Returns: The number of notes in the database
    func countCourses() -> Int {
        return courses.count
    }
    
    func addCourse(course: Course){
        courses.append(course)
    }
    
    func tester(){
        
    }
}
