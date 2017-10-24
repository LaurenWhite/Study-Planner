//
//  CountdownViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/20/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    var interval: Int = 0 //in seconds
    //var timerIsRunning = false
    var myTimer = Timer()
    var instructions = ["Work for 25 minutes!","Take a 5 minute break!","Work for 25 minutes!","Take a 5 minute break!","Work for 25 minutes!","Take a 5 minute break!","Work for 25 minutes!","Take a 5 minute break!","Take a 30 minute break!"]
    var instructionsCompleted = 0
    var formattedTime: String = ""
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.text = instructions[instructionsCompleted]
        initiateTimer()
    }
    
    //Function starts the timer, sets the time based on the instruction
    private func initiateTimer(){
        if(instructionsCompleted%2 == 0){interval = 10}
        else if(instructionsCompleted == 8-1){interval = 20}
        else{interval = 5}
        
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector (CountdownViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    //Timer calls this function every second, changes interval, prints time, checks if time is up
    @objc func updateTimer(){
        interval -= 1
        timerLabel.text = timeFormat(givenTime: interval)
        if (interval == 0){
            finished()
        }
    }
    
    //When timer reaches 0, this function stops the timer, checks if it needs to start again
    func finished(){
        myTimer.invalidate()
        if(instructionsCompleted < 8){
            nextInstruction()
        }
    }
    
    //If the timer needs to start again, this function resets and starts again
    func nextInstruction(){
        instructionsCompleted += 1
        instructionLabel.text = instructions[instructionsCompleted]
        print(instructionsCompleted)
        initiateTimer()
    }
    
    //Returns given seconds integer as nice-looking timer format
    func timeFormat(givenTime: Int) -> String {
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.minute, .second]
        timeFormatter.unitsStyle = .positional
        return timeFormatter.string(from: TimeInterval(givenTime))!
        
    }
    
}
