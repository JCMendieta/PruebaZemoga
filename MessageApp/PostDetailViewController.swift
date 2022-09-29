//
//  PostDetailViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    let arregloEjemplo = ["abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo" ]
    
    weak var coordinator: MainCoordinator?
    
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
        title.text = postTitle
        return title
    }()
    
    lazy var postDescriptionLabel: UITextView = {
        let description = UITextView()
        description.text = postBody
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    lazy var authorNameLabel: UILabel = {
        let author = UILabel()
        author.text = postAuthorName
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
    
    let postTitle: String
    let postBody: String
    let postAuthorName: String
   // let postDescription: String
    //alet postComments: [String]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post Details"
        view.backgroundColor = .white
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(postDescriptionLabel)
        stack.addArrangedSubview(authorNameLabel)
        
        view.addSubview(stack)
        view.addSubview(commentsTableView)
        
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        commentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        commentsTableView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20).isActive = true
    }
    
    init(postTitle: String, postBody: String, author: String) {
        self.postTitle = postTitle
        self.postBody = postBody
        self.postAuthorName = author
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

extension PostDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloEjemplo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = arregloEjemplo[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of comments:"
    }
}
