//
//  ProfileController.swift
//  iRun
//
//  Created by Nazirul Hasan on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    let defaults = UserDefaults.standard
    
    @IBAction func saveButton(_ sender: Any) {
        let n = nameField.text
        let e = emailField.text
        let p = passField.text
        
        defaults.set(n, forKey: "name")
        defaults.set(e, forKey: "email")
        defaults.set(p, forKey: "password")
        
        showToast(controller: self, message : "Successfully name and email saved !", seconds: 2.0)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        nameField.text = defaults.string(forKey: "name")
        emailField.text = defaults.string(forKey: "email")
        passField.text = defaults.string(forKey: "password")
        
        imageField.image = UIImage(named: "avator_profile")
    
        
        
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
