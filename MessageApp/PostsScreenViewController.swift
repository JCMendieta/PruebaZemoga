//
//  ViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostsScreenViewController: UIViewController {

    weak var coordinator: MainCoordinator?
//    var arregloEjemplo = ["abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", ]
//    var arregloFavoritos = [String]()
    
    var postsScreenViewModel = PostsScreenViewModel(posts: [], favoritePosts: []) {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.identifier)
        tableView.rowHeight = 50
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationItem.title = "Posts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllNonFavorites))
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setUpTableView()
        
        postsScreenViewModel = PostsScreenViewModel(
            posts:
                [
                    PostViewModel(title: "post1NoFav", isFavorite: false),
                    PostViewModel(title: "post2NoFav", isFavorite: false),
                    PostViewModel(title: "post3NoFav", isFavorite: false),
                    PostViewModel(title: "post4NoFav", isFavorite: false),
                    PostViewModel(title: "post5NoFav", isFavorite: false),
                    PostViewModel(title: "post6NoFav", isFavorite: false),
                    PostViewModel(title: "post7NoFav", isFavorite: false),
                    PostViewModel(title: "post8NoFav", isFavorite: false)
                ],
            favoritePosts: [FavoritePostViewModel]())
    }
    
    @objc func deleteAllNonFavorites(){
        print("Eliminar post que no son favoritos")
    }
    
    func setUpTableView(){
//        tableView.contentInset = UIEdgeInsets.init(top: -35, left: 0, bottom: 0, right: 0)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}

extension PostsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return postsScreenViewModel.favoritePosts.count
        }
        else {
            return postsScreenViewModel.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier, for: indexPath) as! PostViewCell
        var content = cell.defaultContentConfiguration()
        
        let isFavorite = indexPath.section == 0
        
        if isFavorite {
            let favoritePostTitle = postsScreenViewModel.favoritePosts[indexPath.row].post.title
            content.text = favoritePostTitle
        } else {
            let postTitle = postsScreenViewModel.posts[indexPath.row].title
            content.text = postTitle
        }
        
        cell.contentConfiguration = content
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isFavorite = indexPath.section == 0
        
        if isFavorite {
            coordinator?.showPostDetails(title: postsScreenViewModel.favoritePosts[indexPath.row].post.title)
        } else {
            coordinator?.showPostDetails(title: postsScreenViewModel.posts[indexPath.row].title)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Favorites"
        } else {
            return "All posts"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return 20
        }
    }
    
    
}

extension PostsScreenViewController: PostViewCellDelegate {
    func addOrRemoveFavorite(in cell: PostViewCell) {
        
        if let indexPathTapped = tableView.indexPath(for: cell){
            let post = postsScreenViewModel.posts[indexPathTapped[1]]
            if indexPathTapped[0] == 0 {
                postsScreenViewModel.removeFromFavorite(at: indexPathTapped[1])
//                postsScreenViewModel.favoritePosts.remove(at: indexPathTapped[1])
            } else {
                cell.isFavorite = true
                postsScreenViewModel.addToFavorite(post: post, indexRow: indexPathTapped[1])
//                postsScreenViewModel.favoritePosts.append(post)
            }
            tableView.reloadData()
            
            
        }
        
        
        
        
    }
}

