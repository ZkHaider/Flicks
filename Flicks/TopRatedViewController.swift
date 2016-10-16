//
//  ViewController.swift
//  Flicks
//
//  Created by Haider Khan on 10/15/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit
import KRProgressHUD

class TopRatedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /***********************************
     * Views
     ***********************************/

    @IBOutlet weak var topRatedTableView: UITableView!
    
    /***********************************
     * Variables
     ***********************************/

    var topRatedMovies: [Movie] = []
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    /***********************************
     * LifeCycle Methods
     ***********************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.title = "Top Rated"
        
        // Add a refresh control
        refreshControl.backgroundColor = UIColor.black
        refreshControl.tintColor = UIColor.yellow
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)
        self.topRatedTableView.addSubview(refreshControl)

        
        // Set the alpha value on the table view to 0.0 initially until movies load
        topRatedTableView.alpha = 0.0
        
        // Set delegate and datasource
        topRatedTableView.dataSource = self
        topRatedTableView.delegate = self
        
        // Register the cell 
//        self.topRatedTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "topRatedMovieCell")
        
        KRProgressHUD.show(message: "Loading current movies...")
        
        loadTopMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /***********************************
     * TableView Methods
     ***********************************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topRatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Convert to a movie cell 
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "topRatedMovieCell", for: indexPath) as! TopRatedMovieTableViewCell
        
        // We have the movie cell go ahead and cell our movie object
        let movie = topRatedMovies[indexPath.row]
                
        // Set our movie
        movieCell.setMovie(movie: movie)
        
        // Return our cell
        return movieCell
    }
    
    /***********************************
     * Accessory Methods
     ***********************************/
    
    func pullToRefresh() {
        loadTopMovies()
    }
    
    func loadTopMovies() {
        
        // Load top movies
        MovieAPI.getTopRatedMovies(completion: { topRated in
            self.topRatedMovies = topRated.results
            
            DispatchQueue.main.async {
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                
                self.tabBarController?.tabBar.items![1].badgeValue = String(self.topRatedMovies.count)
                
                // Animate in the tableview on the main thread
                UIView.animate(withDuration: 0.1, animations: {
                    self.topRatedTableView.alpha = 1.0
                    }, completion: {(_) -> Void in
                        
                        if KRProgressHUD.isVisible {
                            KRProgressHUD.dismiss()
                        }
                })
                self.topRatedTableView.reloadData()
            }
        })

    }

}

