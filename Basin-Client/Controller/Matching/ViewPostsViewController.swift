//
//  ShowMatchesViewController.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/4/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class ViewPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var matchedUsers = [PublicUserInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if matchedUsers.count == 0 {
            fetchMoreMatches()
        }
    }
    
    func fetchMoreMatches(){
        let spinner = ActivityIndicatorView(coveringView: self.view, withMessage: "Fetching Matches...")
        
        //This promise will get this user's matches from the server.
        RequestManager.fetchMatches().done { matches  in
            self.matchedUsers = matches
            spinner.stop()
            if self.matchedUsers.count == 0 {
                self.presentDialogBox(withTitle: "No Matches Found", withMessage: "Sorry, we couldn't find any matches for you right now. Check back later!")
            }
        }.catch { error in
            self.presentDialogBox(withTitle: "Error", withMessage: "In ViewPostsViewController.fetchMoreMatches(): \(error)")
            spinner.stop()
        }
        
        
    }
    
    
    //MARK -- Required by TableView protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if matchedUsers.count == 0 {
            return 0
        } else {
            return 5 //Not final by any means
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Todo: Implement this.
        //Question: How will we really implement the matched users?
        //For now, I'll use the Baseball Card idea: One person can be viewed at a time, so the cells will contain user info...?
        guard let user = matchedUsers.first else {
            presentDialogBox(withTitle: "Error", withMessage: "Debug: The current user/first user in matchedUsers is nil AND the cellForRowAtIndexPath method was called. Figure out a way to prevent this from happening. Returning an empty cell for now...")
            return UITableViewCell()
        }
        switch  indexPath.row {
        case 0:
            let cell = ProfilePictureTableViewCell()
            //Do Profile Picture stuff here
            //This entire control flow is very preliminary, by the way, so don't get too attached to it...
            //Profile Picture infrastructure doesn't exist yet, so we won't do anything here (yet)
            return cell
        case 1:
            let cell = NameTableViewCell()
            cell.nameLabel.text = user.name
            return cell
        default:
            let cell = KeyedTextTableViewCell()
            cell.keyLabel.text = "Distance \(indexPath.row):"
            cell.keyLabel.text = "Value \(indexPath.row); \(user.distance)"
            return cell
        }
        
        
        
    }
    
}
