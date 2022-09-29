//
//  ViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostsScreenViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var viewModel = PostsScreenViewModel(posts: [], favoritePosts: []) {
        didSet {
            tableView.reloadData()
        }
    }
    
    var users = [User]()
    
    var fetchPostsManager = FetchPostsManager()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Posts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllNonFavorites))
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setUpTableView()
        
        fetchPostsManager.delegate = self
        fetchPostsManager.fetchPosts()
        fetchPostsManager.fetchUsers()
        
    }
    
    @objc func deleteAllNonFavorites(){
        viewModel.removeNotFavoritePosts()
        tableView.reloadData()
    }
    
    func setUpTableView(){
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func getAuthor(with id: Int) -> String {
        print(users[id - 1].name)
        return users[id - 1].name
//        let user = users.filter { user in
//            user.id == id
//        }
//        guard let author = user.first?.name else { return "" }
//        return author
        
    }
}

extension PostsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.favoritePosts.count
        }
        else {
            return viewModel.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier, for: indexPath) as! PostViewCell
        var content = cell.defaultContentConfiguration()
        
        let isFavorite = indexPath.section == 0
        
        if isFavorite {
            let favoritePostTitle = viewModel.favoritePosts[indexPath.row].post.title
            content.text = favoritePostTitle
        } else {
            let postTitle = viewModel.posts[indexPath.row].title
            content.text = postTitle
        }
        cell.contentConfiguration = content
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isFavorite = indexPath.section == 0
        

        if isFavorite {
            let post = viewModel.favoritePosts[indexPath.row].post
            let author = getAuthor(with: post.userId)
            coordinator?.showPostDetails(title: post.title, body: post.body, author: author, postId: post.postId)
        } else {
            let post = viewModel.posts[indexPath.row]
            let author = getAuthor(with: post.userId)
            coordinator?.showPostDetails(title: post.title, body: post.body, author: author, postId: post.postId)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                viewModel.removePostFromfavoriteWith(index: indexPath[1])
            } else {
                viewModel.removePostWith(index: indexPath[1])
            }
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
            let post = viewModel.posts[indexPathTapped[1]]
            if indexPathTapped[0] == 0 {
                viewModel.removeFromFavorite(at: indexPathTapped[1])
//                postsScreenViewModel.favoritePosts.remove(at: indexPathTapped[1])
            } else {
                cell.isFavorite = true
                viewModel.addToFavorite(post: post, indexRow: indexPathTapped[1])
//                postsScreenViewModel.favoritePosts.append(post)
            }
            tableView.reloadData()
        }
    }
}

extension PostsScreenViewController: FetchPostsManagerDelegate {
    func didUpdateUsers(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
        }
    }
    
    
    func didUpdatePosts(with viewModel: PostsScreenViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
        }
    }
}

