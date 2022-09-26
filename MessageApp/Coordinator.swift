//
//  Coordinator.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 26/09/22.
//
import UIKit

protocol Coordinator {
    var children : [Coordinator] { get set}
    var nav: UINavigationController {get set}
    
    func start()
    
}
