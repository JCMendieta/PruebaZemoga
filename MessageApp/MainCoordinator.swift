//
//  MainCoordinator.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 26/09/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init( navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postsScreen = PostsScreenViewController()
        postsScreen.coordinator = self
        navigationController.pushViewController(postsScreen, animated: false)
    }
    
    func showPostDetails(title: String, body: String) {
        let postDetailScreenVC = PostDetailViewController(postTitle: title, postBody: body)
        postDetailScreenVC.coordinator = self
        navigationController.pushViewController(postDetailScreenVC, animated: true)
    }
    
}
