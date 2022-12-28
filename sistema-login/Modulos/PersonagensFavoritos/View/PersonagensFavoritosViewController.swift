//
//  PersonagensFavoritosViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class PersonagensFavoritosViewController: UIViewController {
    
    // MARK: - View
    private lazy var personagensFavoritosView: PersonagensFavoritosView = {
        let view = PersonagensFavoritosView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagensFavoritosView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }

}
