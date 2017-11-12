//
//  FirstViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/16/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //UI PROPERTIES OUTLETS
    @IBOutlet weak var dateLabel: UILabel!      //Date label at top
    @IBOutlet weak var taskTableView: UITableView! //Table View showing all tasks
    
    let taskDatabase = TaskDatabase()
    
    //Function that runs when this view controller is opened/loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let todaysDate = dateFormatter.string(from: date)
        dateLabel.text = todaysDate
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        self.title = "To-Do List"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return taskDatabase.activeCourses().0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskDatabase.activeCourses().1[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let header = self.tableView(taskTableView, titleForHeaderInSection: section)
        return taskDatabase.tasksInCoures(courseTitle: header!).0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
        let header = self.tableView(taskTableView, titleForHeaderInSection: indexPath.section)
        let task = taskDatabase.tasksInCoures(courseTitle: header!).1[indexPath.row] //self.taskDatabase.currentTask(atIndex: indexPath.row)
        cell.textLabel?.text = task.taskTitle
        if (task.completion) {
            cell.detailTextLabel?.text = "✔︎"
        }else{
            cell.detailTextLabel?.text = dueIn(givenDueDate: task.dueDate, cell: cell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            //Is deleting the wrong row right now. Index path wrong?
            print(taskDatabase.currentTask(atIndex: indexPath.row).taskTitle)
            //var index = taskDatabase.currentTask(atIndex: <#T##Int#>)
            taskDatabase.removeTask(int: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let taskVC = segue.destination as? TaskDetalisViewController {
            // Show existing task
            if let selectedCell = sender as? UITableViewCell,
                let selectedIndex = taskTableView.indexPath(for: selectedCell) {
                taskVC.task = self.taskDatabase.currentTask(atIndex: selectedIndex.row)
            }
        }
        if let taskVC = segue.destination as? TaskEditorViewController {
            // Show existing task
            if let selectedCell = sender as? UITableViewCell,
                let selectedIndex = taskTableView.indexPath(for: selectedCell) {
                taskVC.task = self.taskDatabase.currentTask(atIndex: selectedIndex.row)
            }
            taskVC.saveNotification = self.saveNew
        }
    }
    
    private func saveNew(task: Task) {
        taskDatabase.saveNew(task: task)
        taskTableView.reloadData()
    }
    
    
    //Returns the due date in the form of shortened day of the week if less than 7 days
    //or in M/D form if further than 7 days, also states as "Today" or "Tomorrow" if
    //due on those days. Changes text to red to indicate urgency for today & tom.
    private func dueIn(givenDueDate: Date, cell: UITableViewCell) -> String{
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let dueDateMonth = calendar.component(.month, from: givenDueDate)
        let currentDay = calendar.component(.day, from: Date())
        let dueDateDay = calendar.component(.day, from: givenDueDate)
        var formattedDueDate: String = ""
        let daysBetween = calendar.dateComponents([.day], from: Date(), to: givenDueDate).day!
        
        
        if ((givenDueDate < Date()) && (currentDay != dueDateDay)){
            formattedDueDate = "✘"
        } else if (daysBetween <= 7){
            let daysUntilDue = dueDateDay - currentDay
            let dayOfWeek = calendar.component(.weekday, from: givenDueDate)
            let weekdays = ["Sun","Mon","Tues","Wed","Thurs","Fri","Sat"]
            
            if (daysUntilDue==0){formattedDueDate = "Today"; cell.detailTextLabel?.textColor = UIColor.red}
            else if (daysUntilDue==1){formattedDueDate = "Tommorow"; cell.detailTextLabel?.textColor = UIColor.red}
            else if (daysUntilDue<=7){formattedDueDate = weekdays[dayOfWeek-1]}
            else {formattedDueDate = String(dueDateMonth)+"/"+String(dueDateDay)}
        }else {formattedDueDate = String(dueDateMonth)+"/"+String(dueDateDay)}
        return formattedDueDate
    }
}

