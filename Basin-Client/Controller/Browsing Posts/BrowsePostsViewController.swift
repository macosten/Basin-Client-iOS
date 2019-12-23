//
//  ShowMatchesViewController.swift
//  Conflux-Client
//
//  Created by Zaccari Silverman on 7/4/19.
//  Copyright © 2019 macosten. All rights reserved.
//

import UIKit

class BrowsePostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PostLocalRepresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the tableView's delegate and data source.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BrowsePostsTableViewCell", bundle: nil), forCellReuseIdentifier: "BrowsePostsTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if posts.count == 0 {
            fetchActivePosts()
        }
        
    }
    
    func fetchActivePosts(){
        let spinner = ActivityIndicatorView(coveringView: self.view, withMessage: "Fetching Posts...")

        // Do a data task.
        
        spinner.stop()
    }
    
    func fetchAllPosts(){
        
    }
    
    //MARK -- Required by TableView protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Todo: Implement this.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BrowsePostsTableViewCell", for: indexPath) as? BrowsePostsTableViewCell else {
            print("Dequeueing BrowsePostsTableViewCell failed.")
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        
        cell.postTitleLabel.text = post.title
        cell.postUsernameLabel.text = post.username
        
        return cell
    }
    
}
