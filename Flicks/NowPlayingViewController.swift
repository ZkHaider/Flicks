//
//  NowPlayingViewController.swift
//  Flicks
//
//  Created by Haider Khan on 10/15/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit
import KRProgressHUD

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    /***********************************
     * Views
     ***********************************/
    
    @IBOutlet weak var nowPlayingTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    /***********************************
     * Variables
     ***********************************/

    var nowPlayingMovies: [Movie] = []
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    /***********************************
     * LifeCycle Methods
     ***********************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // Add title on the nav bar
        self.navigationItem.title = "Now Playing"
        
        // Set the alpha value on the tableview to 0.0 until the movies load in 
        self.nowPlayingTableView.alpha = 0.0
        
        // Add a refresh control
        refreshControl.backgroundColor = UIColor.black
        refreshControl.tintColor = UIColor.yellow
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)
        self.nowPlayingTableView.addSubview(refreshControl)
        
        // Initialize our search bar 
        searchBar.placeholder = "Search for a movie"
        searchBar.delegate = self
        
        // Let search end editing by tapping anywhere
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        searchBar.addGestureRecognizer(tap)

        // Set delegate and datasource
        nowPlayingTableView.dataSource = self
        nowPlayingTableView.delegate = self
        
        KRProgressHUD.show(message: "Loading current movies...")
        
        loadCurrentMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /***********************************
     * TableView Methods
     ***********************************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Convert to a movie cell
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingMovieCell", for: indexPath) as! NowPlayingMovieTableViewCell
        
        // We have the movie cell go ahead and cell our movie object
        let movie = nowPlayingMovies[indexPath.row]
                
        // Set our movie
        movieCell.setMovie(movie: movie)
        
        // Return our cell
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Go ahead and instantiate view controller
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "movieDetailViewController") as! MovieDetailViewController
        
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }

    /***********************************
     * SearchBar Methods
     ***********************************/
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Clear search
        self.searchBar.text = ""
        
        // TODO... search API
        
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // Clear search
        self.searchBar.text = ""
        
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
    }
    
    /***********************************
     * Accessory Methods
     ***********************************/

    func dismissKeyboard() {
        self.searchBar.endEditing(true)
    }
    
    func pullToRefresh() {
        loadCurrentMovies()
    }
    
    func loadCurrentMovies() {
        
        // Go ahead and load the now playing movies
        MovieAPI.getNowPlayingMovies(completion: { nowPlaying in
            self.nowPlayingMovies = nowPlaying.results
            
            DispatchQueue.main.async {
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                
                self.tabBarController?.tabBar.items![0].badgeValue = String(self.nowPlayingMovies.count)
                
                // Animate in the tableview on the main thread
                UIView.animate(withDuration: 0.1, animations: {
                    self.nowPlayingTableView.alpha = 1.0
                    }, completion: {(_) -> Void in
                        
                        if KRProgressHUD.isVisible {
                            KRProgressHUD.dismiss()
                        }
                })
                self.nowPlayingTableView.reloadData()
            }
        })

    }
    
}
