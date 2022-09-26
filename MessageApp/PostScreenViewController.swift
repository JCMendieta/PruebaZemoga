//
//  ViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Posts"
        //navigationController?.navigationBar.backgroundColor = .
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(mostrarvc))
        // Do any additional setup after loading the view.
    }
    @objc func mostrarvc(){
        let vc = PostDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}


