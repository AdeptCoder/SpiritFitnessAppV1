//
//  LoginController.swift
//  MyUserRegistration
//
//  Created by Niraj Thanki on 4/2/17.
//  Copyright © 2017 Niraj Thanki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
var workoutRef: FIRDatabaseReference!
var walkmeterRef: FIRDatabaseReference!
class LoginController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    
    @IBAction func RegisterButton(_ sender: Any) {
        let loginPageController = (
            storyboard?.instantiateViewController(
                withIdentifier: "Registration")
            )!
        loginPageController.modalTransitionStyle = .crossDissolve
        present(loginPageController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(FIRApp.defaultApp() == nil){
        FIRApp.configure()
        }
        workoutRef = FIRDatabase.database().reference().child("workoutData")
        walkmeterRef = FIRDatabase.database().reference().child("walkmeter")
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RegistrationController.dismissKeyboard)))
        passwordtxt.delegate = self
  }

    // for tapping outside the text field
    func dismissKeyboard() {
        passwordtxt.resignFirstResponder()
    }
    
    // for hitting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func loginAction(_ sender: Any) {
        if self.emailtxt.text == "" || self.passwordtxt.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailtxt.text!, password: self.passwordtxt.text!) { (user, error) in
                
                if error == nil {
                    let id = user?.uid
                    print("DATA::::::::\(FIRDatabase.database().reference().child("registeredusers").child(id!))")
                    FIRDatabase.database().reference().child("registeredusers").child(id!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                        let userDictionary = snapshot.value as? [String:Any]!
                        print("DICTIONARY:::::\(userDictionary)")
                         SingletonClass.shared.userDict = userDictionary!
                        SingletonClass.shared.userid = userDictionary?["id"] as! String
                        SingletonClass.shared.username = userDictionary?["name"] as! String
                        SingletonClass.shared.useremail = userDictionary?["email"] as! String
                        SingletonClass.shared.userage = userDictionary?["age"] as! String
                         SingletonClass.shared.usersex = userDictionary?["sex"] as! String
                        SingletonClass.shared.userweight = userDictionary?["weight"] as! String
                    })
                    
                    SingletonClass.shared.isLoggedin = true
                    self.dismiss(animated: true,completion: nil)
                    let alertController = UIAlertController(title: "SUCCESS!", message: "You Have Successfully Log in.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                   
                } else {
                    SingletonClass.shared.isLoggedin = false
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
}

