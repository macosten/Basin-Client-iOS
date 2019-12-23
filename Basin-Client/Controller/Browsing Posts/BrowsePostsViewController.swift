//
//  ShowMatchesViewController.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/4/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class BrowsePostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts = [PostLocalRepresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if posts.count == 0 {
            fetchActivePosts()
        }
    }
    
    func fetchActivePosts(){
        let spinner = ActivityIndicatorView(coveringView: self.view, withMessage: "Fetching Posts...")

        
    }
    
    func fetchAllPosts(){
        
    }
    
    //MARK -- Required by TableView protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Todo: Implement this.
        
        return UITableViewCell()
        
    }
    
}
