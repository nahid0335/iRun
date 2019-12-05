//
//  SQLiteDatabase.swift
//  iRun
//
//  Created by Nazirul Hasan on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteDatabase{
    
    
    public static func getWorkOutDatabase()->OpaquePointer{
        var db:OpaquePointer?

        let fileUrl = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("iRunDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error opening database")
        }
        
        let createTableQuery1 = "CREATE TABLE IF NOT EXISTS Workout (workout_id INTEGER PRIMARY KEY AUTOINCREMENT, workout_time TEXT,workout_distance REAL)"
        
        if sqlite3_exec(db, createTableQuery1, nil, nil, nil) != SQLITE_OK{
            print("Error creating table")
        }
        
        return db!
    }
    
    public static func getUserDatabase()->OpaquePointer{
        var db:OpaquePointer?
        
        let fileUrl = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("iRunDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error opening database")
        }
        
        let createTableQuery1 = "CREATE TABLE IF NOT EXISTS User (user_id INTEGER PRIMARY KEY, user_name TEXT,user_email TEXT)"
        
        if sqlite3_exec(db, createTableQuery1, nil, nil, nil) != SQLITE_OK{
            print("Error creating table")
        }
        
        return db!
    }
    
    
    
}
