//
//  ViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var loginScreen: LoginScreen = {
        let view = LoginScreen(frame: .zero, loginViewController: self)
        return view
    }()
    
    // MARK: - Swift
    override func loadView() {
        self.view.addSubview(self.loginScreen)
        loginScreen.cadastrarButton.addTarget(
            self, action: #selector(redirecionarParaTelaDeCriacaoDeContato),
            for: .touchUpInside
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Funcoes
    @objc func redirecionarParaTelaDeCriacaoDeContato() -> Void { // pq esse _ sender
        guard let navigationController = self.navigationController else { return }
        
        let criacaoDeContatoViewController = CriacaoDeContatoViewController()
        
        navigationController.pushViewController(criacaoDeContatoViewController, animated: true)
    }
    
}
