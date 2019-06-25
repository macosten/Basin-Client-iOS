//
//  LoginViewController.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 6/23/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //Beware that App Transport currently allows plain HTTP loads. Disable this when Vapor 4 comes out and allows SSL out of the box.
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        //authorize the user...
        
        //Let's start the spinning activity indicator first.
        let spinner = ActivityIndicatorView(coveringView: self.view, withMessage: "Logging in...")
        
        guard let email = emailTextField.text else {
            presentDialogBox(withTitle: "Error", withMessage: "You need to provide your email address.")
            return
        }
        
        guard let password = passwordTextField.text else {
            presentDialogBox(withTitle: "Error", withMessage: "Please enter your password.")
            return
        }
        
        let authCredentials = BasicAuthCredentials(username: email, password: password)
        RequestManager.userLogin(basicAuthCredentials: authCredentials).map { result in
            
            if !result.contains(" ") {
                //If we're here, then the login should be a success. Let's save these credentials.
                KeychainManager.username = email
                KeychainManager.password = password
                KeychainManager.token = result
                
                //Stop the spinner.
                spinner.stop()
            
                //This is the part where I'd normally move to another ViewController and handle stuff there, but for now, I just want to test logins.
                self.presentDialogBox(withTitle: "Success", withMessage: "The login was a success, but for now there's nothing else to do. Your token is \(result), by the way, and it has been saved.")
                //This is where we'd save the token and transition to the main area of the app.
            } else {
                //Stop the spinner.
                spinner.stop()
                
                self.presentDialogBox(withTitle: "Failure", withMessage: "The login failed. The message returned by the server was: \(result)")
            }
        }.catch { error in
            //Stop the spinner.
            spinner.stop()
            
            self.presentDialogBox(withTitle: "Error", withMessage: "There was an error logging in: \(error.localizedDescription). Check to make sure you entered everything correctly.")
        }
    }
    
    
}
