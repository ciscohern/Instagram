//
//  HomeViewController.swift
//  instagram
//
//  Created by Francisco Hernanedez on 10/2/18.
//  Copyright © 2018 Francisco Hernanedz. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: ViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var posts: [PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        didPullToRefresh(refreshControl)
        //        fetchPosts()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(){
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground{ (Post, error: Error?) in
            if let posts = Post {
                // do something with the data fetched
                //                print(posts)
                self.posts = posts
                print(self.posts)
                self.tableView.reloadData()
                
            } else {
                // handle error
                print(error?.localizedDescription)
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailSegue"){
            print("detailSegue")
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailsViewController
                detailViewController.post = post
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(posts.count > 20){
            return 20
        }
        else{
            return posts.count
        }
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        let caption = post["caption"] as! String
        cell.CaptionUILable.text = caption
        let imageFile = post["media"] as? PFFile
        
        if let imageFile : PFFile = imageFile {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        // Async main thread
                        let image = UIImage(data: data!)
                        cell.PostImageView.image = image
                        
                    }
                    
                } else {
                    print(error!.localizedDescription)
                    
                }
                
            })
        }
        
        return cell
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
