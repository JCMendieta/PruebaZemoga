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
        navigationController.pushViewController(postsScreen, animated: false)
    }
    
    
}
