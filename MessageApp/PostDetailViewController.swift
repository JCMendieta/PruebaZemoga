//
//  PostDetailViewController.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 25/09/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = postTitle
        return title
    }()
    
    let postTitle: String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post Details"
        view.backgroundColor = .white
        
        stack.addArrangedSubview(titleLabel)
        view.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        // Do any additional setup after loading the view.
    }
    
    init(postTitle: String) {
        self.postTitle = postTitle
        
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
