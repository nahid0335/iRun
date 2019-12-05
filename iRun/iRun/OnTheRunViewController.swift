//
//  OnTheRunViewController.swift
//  iRun
//
//  Created by Mohammad Shamim on 28/10/19.
//  Copyright © 2019 Mohammad Shamim. All rights reserved.
//

import UIKit
import MediaPlayer
import SQLite3
import AVFoundation


class OnTheRunViewController: UIViewController {
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var mediaThumbnailImage: UIImageView!
    @IBOutlet weak var mediaMetadataLabel: UILabel!
    @IBOutlet weak var mediaPlayPauseButton: UIButton!
    @IBOutlet weak var stickmanIcon: UIButton!
    
    
    var totalSecond = 300
    var totalDistance = 0.42
    var distance = 0.00
    
    
    var player: AVAudioPlayer?

    // Get the music player.
    let musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    //let defaults = UserDefaults.standard
    var day = 0 //can be between 0 and 6 ; total 7 weeks plan
    var seconds = 3 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = 0
    var playStatus = 0 //0=init, 1=playing, 2=paused
    
    var mode = 0
    var actionCount = 1 // walk, jog, blah blah
    var actionStatus : [String] = ["Warm Up", "Jog", "Walk", "Cool Down", "Run"]
    var actionTime : [[[Int]]] = [
        
        [    [0,3],
            [1,2],
        [3,3]   ],

        
        [    [0,300],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
        [3,300]   ],
        [    [0,300],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
        [3,300]   ],
        [    [0,300],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
            [1,60], [2,90], [1,60], [2,90],
        [3,300]   ],
        
        
        [    [0,300],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
        [3,300]   ],
        [    [0,300],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
        [3,300]   ],
        [    [0,300],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
            [1,90], [2,120], [1,90], [2,120],
        [3,300]   ],
        
        
        [    [0,300],
            [1,90], [2,90], [1,180], [2,180],
            [1,90], [2,90], [1,180], [2,180],
        [3,300]   ],
        [    [0,300],
            [1,90], [2,90], [1,180], [2,180],
            [1,90], [2,90], [1,180], [2,180],
        [3,300]   ],
        [    [0,300],
            [1,90], [2,90], [1,180], [2,180],
            [1,90], [2,90], [1,180], [2,180],
        [3,300]   ],
        
        
        [    [0,300],
            [1,180], [2,90], [1,300], [2,150],
            [1,180], [2,90], [1,300],
        [3,300]   ],
        [    [0,300],
            [1,180], [2,90], [1,300], [2,150],
            [1,180], [2,90], [1,300],
        [3,300]   ],
        [    [0,300],
            [1,180], [2,90], [1,300], [2,150],
            [1,180], [2,90], [1,300],
        [3,300]   ],
        
        
        [    [0,300],
            [1,300], [2,180], [1,300], [2,180],
            [1,300],
        [3,300]   ],
        [    [0,300],
            [1,480], [2,300], [1,480],
        [3,300]   ],
        [    [0,300],
            [1,1200],
        [3,300]   ],
        
        
        [    [0,300],
            [1,300], [2,180], [1,480], [2,180],
            [1,300],
        [3,300]   ],
        [    [0,300],
            [1,600], [2,180], [1,600],
        [3,300]   ],
        [    [0,300],
            [1,1320],
        [3,300]   ],
        
        
        [    [0,300],
            [1,1500],
        [3,300]   ],
        [    [0,300],
            [1,1500],
        [3,300]   ],
        [    [0,300],
            [1,1500],
        [3,300]   ]
        
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //day = Int(defaults.string(forKey:"dayNumber")!)! - 1
    
        // Add a playback queue containing all songs on the device.
        musicPlayer.setQueue(with: .songs())
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func startExercise(_ sender: Any) {
//        let sec:timerViewController = timerViewController(nibName: nil, bundle: nil)
//
//        self.presentViewController(secondViewController, animated: true, completion: nil)
//
//    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(OnTheRunViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            
            timerManager()
            
        } else {
            seconds -= 1 //This will decrement(count down)the seconds.
            timerLabel.text = timeString(time: TimeInterval(seconds)) //This will update the label.
        }
    }
    
    
    func timerManager(){
        if actionCount < actionTime[day].count{
            seconds = actionTime[day][actionCount][1]
            mode = actionTime[day][actionCount][0]
            if mode == 0 {
                //playSound(soundName: "lets-go")
                playSound(soundName: "warm-up")
            } else if mode == 1 {
                playSound(soundName: "jog")
            } else if mode == 2 {
                playSound(soundName: "walk")
            } else if mode == 3 {
                playSound(soundName: "cool-down")
            }
            
            totalSecond += seconds
            if actionTime[day][actionCount][0] == 1 {
                totalDistance += 0.0125 * Double(seconds)
            } else {
                totalDistance += 0.0014 * Double(seconds)
            }
            exerciseLabel.text = actionStatus[actionTime[day][actionCount][0]]
            timerLabel.text = timeString(time: TimeInterval(seconds))
            
            if actionTime[day][actionCount][0] == 1 {
                stickmanIcon.setImage(UIImage(named: "running.png"), for: .normal)
            } else if actionTime[day][actionCount][0] == 3 {
                stickmanIcon.setImage(UIImage(named: "walking.png"), for: .normal)
            } else {
                stickmanIcon.setImage(UIImage(named: "marathon-champion.png"), for: .normal)
            }
            
            
            
            actionCount+=1
        } else {
            

            playSound(soundName: "stop")
            exerciseLabel.text = "Finished!"
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timer.invalidate()
            isTimerRunning = false
            resumeTapped = 2
            

            stickmanIcon.setImage(UIImage(named: "marathon-champion.png"), for: .normal)
            
            
            
            self.playPauseButton.setTitle("Done",for: .normal)
            
            
            
            
            
            
            
            
                    let db:OpaquePointer = SQLiteDatabase.getWorkOutDatabase()
                    var stmt: OpaquePointer?
                    let a:String = String(totalSecond)
                    let b:String = String(totalDistance)
                    //let b:String = String(distance)
                    let insertQuery = "INSERT INTO Workout (workout_time,workout_distance) VALUES ('\(a)','\(b)')"
            
                    if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
                        print("Error binding query")
                    }
            
            //        if sqlite3_bind_text(stmt, 1, title, -1, nil) != SQLITE_OK{
            //            print("Error binding title")
            //        }
            
                    if sqlite3_step(stmt) == SQLITE_DONE{
                        print("save successfully")
                    }
                    
            
        }
    }
    
    
    
    func playSound(soundName:String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func readyForRunButton(_ sender: Any) {
        playSound(soundName: "lets-go")
    }
    
    @IBAction func timerPlayPauseButtonTapped(_ sender: Any) {
        if self.resumeTapped == 0{

            mode = actionTime[day][actionCount-1][0]
            if mode == 0 {
                //playSound(soundName: "lets-go")
                playSound(soundName: "warm-up")
            } else if mode == 1 {
                playSound(soundName: "jog")
            } else if mode == 2 {
                playSound(soundName: "walk")
            } else if mode == 3 {
                playSound(soundName: "cool-down")
            }
            
            runTimer()
            self.resumeTapped = 1
            self.playPauseButton.setTitle("Pause",for: .normal)
        } else if resumeTapped == 2 {
            performSegue(withIdentifier: "cancelRunning", sender: self)
            //ekhaane go_home add korte hobe
        } else {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = 0
            self.playPauseButton.setTitle("Resume",for: .normal)
        }
    }
    
   
    
    
    @IBAction func mediaPlayButton(_ sender: Any) {
        if playStatus == 0 {
            playStatus = 1
            // Start playing from the beginning of the queue.
            musicPlayer.play()
            
            
            
            
            mediaPlayPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        } else if playStatus == 1 {
            musicPlayer.pause()
            playStatus = 0
            mediaPlayPauseButton.setImage(UIImage(named: "play-button.png"), for: .normal)
        } else {
            
        }
    }
    @IBAction func mediaNextButton(_ sender: Any) {
        musicPlayer.skipToNextItem()
    }
    
    @IBAction func mediaPrevButton(_ sender: Any) {
        musicPlayer.skipToPreviousItem()
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
