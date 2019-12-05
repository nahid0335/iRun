//
//  IntroViewController.swift
//  iRun
//
//  Created by CSE on 12/2/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = defaults.bool(forKey: "loggedIn")
        
        if value == true{
            performSegue(withIdentifier: "introLink", sender: self)
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func exitbutton(_ sender: Any) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
