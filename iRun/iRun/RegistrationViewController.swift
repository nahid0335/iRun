//
//  RegistrationViewController.swift
//  iRun
//
//  Created by kuetcse on 2/12/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var regEmailField: UITextField!
    @IBOutlet weak var regPasswordField: UITextField!
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
    @IBAction func signUpAction(_ sender: Any) {
        let fname = firstNameField.text
        let lname = lastNameField.text
        let email = regEmailField.text
        let pass = regPasswordField.text
        
        if fname?.isEmpty == true{
            errorTextField.text = "Please enter first name"
            errorTextField.isHidden = false
        }
        else if lname?.isEmpty == true{
            errorTextField.text = "Please enter last name"
            errorTextField.isHidden = false
        }
        else if email?.isEmpty == true{
            errorTextField.text = "Please enter your email"
            errorTextField.isHidden = false
        }
        else if pass?.isEmpty == true{
            errorTextField.text = "Please enter your password"
            errorTextField.isHidden = false
        }
        else{
            let fullname = fname! + " " + lname!
            defaults.set(fullname, forKey: "name")
            defaults.set(email, forKey: "email")
            defaults.set(pass, forKey: "password")
            
            showToast(controller: self, message : "Successfully Registered!", seconds: 2.0)
            
            self.performSegue(withIdentifier: "signId", sender: self)
            
            
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
