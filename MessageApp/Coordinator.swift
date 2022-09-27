//
//  Coordinator.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 26/09/22.
//
import UIKit

protocol Coordinator {
    var childCoordinators : [Coordinator] { get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    
}
