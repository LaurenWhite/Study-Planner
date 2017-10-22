//
//  CountdownViewController.swift
//  Study Planner
//
//  Created by Lauren White on 10/20/17.
//  Copyright © 2017 Lauren White. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    var interval: Int = 30 //in seconds
    //var timerIsRunning = false
    var myTimer = Timer()
    var instructions = ["Work for 25 minutes!","Take a 5 minute break!","Take a 30 minute break!"]
    var instructionsCompleted = 0
    var formattedTime: String = ""
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionLabel.text = instructions[instructionsCompleted]
        initiateTimer()
    }
    
    private func initiateTimer(){
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector (CountdownViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        interval -= 1
        timerLabel.text = timeFormat(givenTime: interval)
        if (interval == 0){
            finished()
        }
    }
    
    func finished(){
        myTimer.invalidate()
        interval = 30
        nextInstruction() }
    
    func nextInstruction(){
        instructionsCompleted += 1
        instructionLabel.text = instructions[instructionsCompleted]
        print(instructionsCompleted)
        initiateTimer()
    }
    
    func timeFormat(givenTime: Int) -> String {
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.minute, .second]
        timeFormatter.unitsStyle = .positional
        return timeFormatter.string(from: TimeInterval(givenTime))!
        
    }
    
}
