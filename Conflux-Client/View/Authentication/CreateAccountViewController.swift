//
//  CreateAccountViewController.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 6/24/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVerifyTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardOnTap()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
        //Error-check; make sure the user did everything they were supposed to.
        guard let name = nameTextField.text, !name.isEmpty else {
            
            self.presentDialogBox(withTitle: "Error", withMessage: "Please enter your name.")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            self.presentDialogBox(withTitle: "Error", withMessage: "Please enter your email address.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.presentDialogBox(withTitle: "Error", withMessage: "Please enter a password. [Since this is alpha software at best, choose a password accordingly.]")
            return
        }
        
        guard let verifyPassword = passwordVerifyTextField.text, !verifyPassword.isEmpty else {
            self.presentDialogBox(withTitle: "Error", withMessage: "Please enter your password a second time in the verification field.")
            return
        }
        
        if password != verifyPassword {
            //The server would reject this even if we didn't catch this error here, but I feel like putting this check here as well...
            self.presentDialogBox(withTitle: "Error", withMessage: "Your password and password verification don't match. Please re-enter them so that they match.")
            return
        }
        //Show a spinner.
        let spinner = ActivityIndicatorView(coveringView: view, withMessage: "Creating User...")
        
        //Make the request.
        let createUserRequest = CreateUserRequest(name: name, email: email, password: password, verifyPassword: verifyPassword)
        RequestManager.createUser(createUserRequest: createUserRequest).map { status in
            //Stop the spinner.
            spinner.stop()
            
            if status.status == "Success" {
                self.presentDialogBox(withTitle: "Success!", withMessage: "\(name), your account was created successfully. You may now log in.")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.presentDialogBox(withTitle: "Error", withMessage: "The server reported an error. It says: \(status.status)")
            }
            
        }.catch { error in
            spinner.stop()
            self.presentDialogBox(withTitle: "Error", withMessage: "There was an error: \(error)")
        }
    
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
