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
    
    override func viewWillAppear(_ animated: Bool) {
        //I'd mess with refresh tokens and whatnot here, but the security I've implemented isn't that sophisticated yet (I plan on it eventually when there's less foundational stuff to do still).
        super.viewWillAppear(animated)
        //Stub. Figure out what to do here later.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        retrieveCredentials()
        // I might also want to attempt an autologin here, but I don't feel like impementing that that right this second.
    }
    
    func retrieveCredentials(){
        //Retrieve the saved credentials from the keychain manager, then autofill them into the appropriate textboxes.
        emailTextField.text = KeychainManager.username
        passwordTextField.text = KeychainManager.password
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
                
                //...and our work here is done; go to the main application now.
                self.gotoMainApplication(animated: true)

            } else {
                //Stop the spinner.
                spinner.stop()
                
                self.presentDialogBox(withTitle: "Failure", withMessage: "The login failed. The message returned by the server was: \(result). Make sure your information was all entered correctly.")
            }
            
        }.catch { error in
            //Stop the spinner.
            spinner.stop()
            
            self.presentDialogBox(withTitle: "Error", withMessage: "There was an error logging in: \"\(error.localizedDescription)\". Check to make sure you entered your email and password correctly, then try again.")
        }
    }
    
    func gotoMainApplication(animated: Bool){
        
        //This is a kinder version of a force-unwrap in that it will tell the user that it messed up before quitting instead of just quitting. I can't think of anything better to do right now.
        guard let nextViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() else {
            let alert = UIAlertController(title: "Fatal Error", message: "Cannot continue: The main app storyboard is broken. Reinstall the app or file a bug report.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { _ in
                fatalError("Storyboard \"Main\" doesn't exist or it doesn't have an initial view controller. The app can't continue; this should never happen.")
            }))
            return
        }
        
        self.present(nextViewController, animated: animated, completion: nil)
    }
    
}
