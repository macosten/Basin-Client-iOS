//
//  ShowMatchesViewController.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/4/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class ShowMatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var matchedUsers = [PublicUserInformation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Todo: Implement this.
        //Question: How will we really implement the matched users?
        //For now, I'll use the Baseball Card idea: One person can be viewed at a time, so the cells will contain user info...?
        return UITableViewCell()
    }
    
}
