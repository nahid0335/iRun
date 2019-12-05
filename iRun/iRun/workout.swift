//
//  workout.swift
//  iRun
//
//  Created by Nazirul Hasan on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation

class WorkOut {
    var workout_id: Int
    var workout_time: String
    var workout_distance: String
    
    init(workout_id: Int,workout_time: String,workout_distance: String){
        self.workout_id = workout_id
        self.workout_time = workout_time
        self.workout_distance = workout_distance
    }
}
