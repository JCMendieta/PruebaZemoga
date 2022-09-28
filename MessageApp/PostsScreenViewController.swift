//
//  ViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostsScreenViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    let arregloEjemplo = ["abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", "abeja" , "baja", "ccooc" , "dardo", ]
    
    
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
    }
    
    @objc func deleteAllNonFavorites(){
        print("Eliminar post que no son favoritos")
    }
    
    func setUpTableView(){
        tableView.contentInset = UIEdgeInsets.init(top: -35, left: 0, bottom: 0, right: 0)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}

extension PostsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloEjemplo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.identifier, for: indexPath) as! PostViewCell
        var content = cell.defaultContentConfiguration()
        content.text = arregloEjemplo[indexPath.row]
        cell.contentConfiguration = content
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showPostDetails(title: arregloEjemplo[indexPath.row])
    }
}

extension PostsScreenViewController: PostViewCellDelegate {
    func addOrRemoveFavorite() {
        print("Agregar o eliminar favorito")
    }
}

