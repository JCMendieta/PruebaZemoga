//
//  PostDetailViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private var comments = [Comment]()
    private let postTitle: String
    private let postBody: String
    private let postAuthorName: String
    private let postId: Int
    private var fetchCommentsManager = FetchPostsDetailsManager()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Title: \(postTitle)"
        stack.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        return title
    }()
    
    lazy var postDescriptionLabel: UITextView = {
        let description = UITextView()
        description.text = postBody
        description.isEditable = false
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    lazy var authorNameLabel: UILabel = {
        let author = UILabel()
        author.text = "Author:\n\(postAuthorName)"
        author.numberOfLines = 0
        author.font = UIFont(name: "Helvetica Neue", size: 12)
        return author
    }()
    
    lazy var commentsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.contentInset = UIEdgeInsets.init(top: -35, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post Details"
        view.backgroundColor = .white
        
        setUpStack()
        setUpCommentsTableView()
        
        fetchCommentsManager.delegate = self
        fetchCommentsManager.getCommentsForPostWith(id: postId)
    }
    
    init(postTitle: String, postBody: String, author: String, postId: Int) {
        self.postTitle = postTitle
        self.postBody = postBody
        self.postAuthorName = author
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStack(){
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(postDescriptionLabel)
        stack.addArrangedSubview(authorNameLabel)
        
        view.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    private func setUpCommentsTableView(){
        view.addSubview(commentsTableView)
        
        commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        commentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        commentsTableView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20).isActive = true
    }
}

// MARK: - TableView Delegates And Configuration
extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = comments[indexPath.row].email
        content.secondaryText = comments[indexPath.row].body
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of comments:"
    }
}

// MARK: - Fetch Delegate
extension PostDetailViewController: FetchPostDetailsManagerDelegate {
    func didUpdateComments(with comments: [Comment]) {
        DispatchQueue.main.async {
            self.comments = comments
            self.commentsTableView.reloadData()
        }
    }
}
