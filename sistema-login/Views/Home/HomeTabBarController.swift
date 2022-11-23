//
//  HomeViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 11/11/22.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.setupTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        // consigo apagar a view de login que esta antes dessa?
    }
    
    private func setupTabBarController() -> Void {
        let tela01 = PersonagemViewController()
        let tela02 = PlanetaViewController()
        let tela03 = NaveViewController()
        
        self.setViewControllers([tela01, tela02, tela03], animated: false)
        
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Personagens"
        items[0].image = UIImage(systemName: "person")
        
        items[1].title = "Planetas"
        items[1].image = UIImage(systemName: "circle")
        
        items[2].title = "Naves"
        items[2].image = UIImage(systemName: "airplane")
    }
}
