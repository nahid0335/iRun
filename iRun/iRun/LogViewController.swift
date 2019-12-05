//
//  LogViewController.swift
//  iRun
//
//  Created by Nazirul Hasan on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit
import SQLite3

class LogViewController: UIViewController {
    
    
    var db: OpaquePointer?
    var workouts: [WorkOut] = []
    
    @IBOutlet weak var totaltimeLabel: UILabel!
    @IBOutlet weak var totaldistanceLabel: UILabel!
    @IBOutlet weak var workoutfinishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let fileUrl = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("iRunDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error opening database")
            return
        }
        
        let createTableQuery1 = "CREATE TABLE IF NOT EXISTS Workout (workout_id INTEGER PRIMARY KEY AUTOINCREMENT, workout_time TEXT,workout_distance REAL)"
        
        if sqlite3_exec(db, createTableQuery1, nil, nil, nil) != SQLITE_OK{
            print("Error creating table")
            return
        }
        
        
//        var stmt: OpaquePointer?
//        let a:String = "2388"
//        let b:String = "100.44"
//        let insertQuery = "INSERT INTO Workout (workout_time,workout_distance) VALUES ('\(a)','\(b)')"
//
//        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
//            print("Error binding query")
//        }
//
////        if sqlite3_bind_text(stmt, 1, title, -1, nil) != SQLITE_OK{
////            print("Error binding title")
////        }
//
//        if sqlite3_step(stmt) == SQLITE_DONE{
//            print("save successfully")
//        }
//        
     
        

        
        workouts = createArray()
        //print(workouts[0].workout_distance)
    
        
        
        
    }
    
    func createArray() -> [WorkOut] {
        var tempworkout: [WorkOut] = []
        
        
        var totaldistance: Double = 0.0
        var totalsecond: Int = 0
        
        var stmt: OpaquePointer?
        var counti: Int=0
        
        
        let selectQuery = "SELECT * FROM Workout"
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                counti+=1
                
                
                let workouttime = (sqlite3_column_text(stmt, 1))
                let workdistance = (sqlite3_column_text(stmt, 2))
                
                let workouttime_str = String(cString:workouttime!)
                let workoutday_int = counti
                let workdistance_double = String(cString: workdistance!)
                
                let distance = Double(workdistance_double)
                totaldistance+=distance!
                
                let secondStr = Int(workouttime_str)
                let timestring = timeString(time: secondStr!)
                totalsecond += secondStr!
                
                
                
                
                
            //print(workdistance_double)
                
                let workout1 = WorkOut(workout_id: workoutday_int, workout_time: timestring, workout_distance: workdistance_double)
                
                //print(workout1.workout_id)
                
                tempworkout.append(workout1)
                
            }
        }
        
        let totalsecondStr = timeString(time: totalsecond)
        
        workoutfinishLabel.text = String (counti)
        totaldistanceLabel.text = String (totaldistance)
        totaltimeLabel.text = totalsecondStr
        
        
        return tempworkout
    }
    
    
    
}


    
    
    extension LogViewController: UITableViewDataSource,UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return workouts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let workoutinit = workouts[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "workoutcell") as! LogTableViewCell
            
            
            cell.setCell(workout: workoutinit)
            
            return cell
        }
        
        
        func timeString(time:Int) -> String {
            let hour = Int(time)/3600
            let timeq = time % 3600
            let minutes = Int(timeq) / 60
            let seconds = Int(timeq) % 60
            return String(format:"%03i:%02i:%02i",hour, minutes, seconds)
        }
        
    }



