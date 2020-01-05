//
//  CreatePostViewController.swift
//  Basin-Client
//
//  Created by Zaccari Silverman on 1/4/20.
//  Copyright © 2020 macosten. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var titleLengthLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var textLengthLabel: UILabel!
    
    @IBOutlet weak var textTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postButtonWasPressed(_ sender: Any) {
            presentDialogBox(withTitle: "Error", withMessage: "Posting is not yet supported.")
    }
    
    

}
