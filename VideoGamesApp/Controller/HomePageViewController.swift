//
//  ViewController.swift
//  VideoGamesApp
//
//  Created by Harun AYDIN on 13.09.2021.
//

import UIKit

class HomePageViewController: UIViewController {

   // @IBOutlet weak var gameListTableView: UITableView!
    @IBOutlet weak var gameListTableView: UITableView! {
        didSet {
            gameListTableView.dataSource = self
            gameListTableView.delegate = self
            let nib = UINib(nibName: "GameTableViewCell", bundle: nil)
            gameListTableView.register(nib, forCellReuseIdentifier: "GameCell")
        }
    }
    var gameCallIndex = 1
    var selectedIndex = 0
    private var games: [Game] = [] {
        didSet {
            gameListTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getGamesToList()
    }
    func getGamesToList() {
        GameNetwork.shared.getGames(page: gameCallIndex) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let result):
                    if let results = result.results {
                        print(results)
                        if (self.games.count) > 0 {
                            // self?.movies = self?.movies + results
                            self.games = self.games + results
                        } else {
                            self.games = results
                        }
                        self.gameCallIndex = self.gameCallIndex + 1
                        
                        // print(self?.movies)
                        self.gameListTableView.reloadData()
                    }
                case .failure(let error):
                   print(error)
                }
            }
       }

    }
}
extension HomePageViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
        cell.updateCell(game: games[indexPath.row])
        return cell
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == games.count - 1 {
            self.gameListTableView.tableFooterView = self.createSpinnerFooter()
           // Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {(t) in
                self.getGamesToList()
            }
         
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "homeToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToDetail" {
            let destVC = segue.destination as! DetailPageViewController
           // destVC.link = self
          //  destVC.modalPresentationStyle = .fullScreen  // full screen modal
         //   destVC.selectedMovie = movies[selectedIndex]
            destVC.selectedGameId = games[selectedIndex].id
        }
    }
    
    
    
    
    
    
}


