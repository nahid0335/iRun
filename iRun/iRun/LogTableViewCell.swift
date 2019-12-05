//
//  LogTableViewCell.swift
//  iRun
//
//  Created by Nazirul Hasan on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellDistanceLabel: UILabel!
    @IBOutlet weak var cellTimeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setCell(workout: WorkOut){
        dayLabel.text = String(workout.workout_id)
        cellTimeLabel.text = workout.workout_time
        cellDistanceLabel.text = String(workout.workout_distance)
    }
}
