//
//  ViewController.swift
//  MyDataMachine_Project
//
//  Created by Anku on 27/04/24.
//

import UIKit

class Post: Codable {
    let id: Int
    let title: String
}

class ViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    var currentPage = 1
    let pageSize = 10
    var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        fetchData()
    }

    func fetchData() {
        guard !isLoadingData else { return }
        isLoadingData = true
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(pageSize)")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let fetchedPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts.append(contentsOf: fetchedPosts)
                    self.isLoadingData = false
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            currentPage += 1
            fetchData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let post = posts[indexPath.row]
        cell.lblData.text = "\(post.id): \(post.title)"
        return cell
    }
}
