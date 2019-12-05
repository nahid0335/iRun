//
//  LoginViewController.swift
//  iRun
//
//  Created by kuetcse on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var logEmailField: UITextField!
    @IBOutlet weak var logPasswordField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTextField.isHidden = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginButtonAction(_ sender: Any) {
        let email = defaults.string(forKey: "email")
        let pass = defaults.string(forKey: "password")
        
        let l_email = logEmailField.text
        let l_pass = logPasswordField.text
        
        if l_email?.isEmpty == true{
            errorTextField.text = "Please enter your email"
            errorTextField.isHidden = false
        }
        else if l_pass?.isEmpty == true{
            errorTextField.text = "Please enter your password"
            errorTextField.isHidden = false
        }
        else{
            
            if(l_email == email && l_pass == pass){

                
                performSegue(withIdentifier: "high", sender: self)
                
                showToast(controller: self, message : "Successfully Logged in !", seconds: 2.0)
            }
            else{
                
                
                showToast(controller: self, message : "Login failed  !", seconds: 2.0)
            }
        
            
            
            
            
            
        }
        
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
