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
    }
    
    private func setupTabBarController() -> Void {
        let tela01 = PersonagemViewController()
        let tela02 = PlanetaViewController()
        let tela03 = NaveViewController()
        let tela04 = PerfilViewController()
        
        self.setViewControllers([tela01, tela02, tela03, tela04], animated: false)
        
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Personagens"
        items[0].image = UIImage(systemName: "person")
        
        items[1].title = "Planetas"
        items[1].image = UIImage(systemName: "circle")
        
        items[2].title = "Naves"
        items[2].image = UIImage(systemName: "airplane")
        
        items[3].title = "Perfil"
        items[3].image = UIImage(systemName: "person.circle")
    }
                                                                                               
}
