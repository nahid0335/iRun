//
//  SettingController.swift
//  iRun
//
//  Created by kuetcse on 27/10/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit
import SQLite3

class SettingController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    
    var db: OpaquePointer = SQLiteDatabase.getWorkOutDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.text = defaults.string(forKey: "name")
        emailField.text = defaults.string(forKey: "email")
        
        
    }
    
 
    @IBAction func logoutButtonAction(_ sender: Any) {
        defaults.set(false,forKey: "loggedIn")
        performSegue(withIdentifier: "logoutToIntro", sender: self)
    }
    

    
    
    @IBAction func clearButton(_ sender: Any) {
            let q = "DELETE FROM Workout"
            
            if sqlite3_exec(db, q, nil, nil, nil) != SQLITE_OK{
                print("Error creating table")
            }
        
        showToast(controller: self, message : "Successfully history cleared !", seconds: 2.0)

        
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Exit ?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             //print("Ok button tapped")
             exit(0)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            //print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }



    
}
