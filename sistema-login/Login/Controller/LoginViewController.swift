//
//  ViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Atributos
    private var loginScreen: LoginScreen?
    
    // MARK: - Swift
    override func loadView() {
        self.loginScreen = LoginScreen(frame: .zero, loginViewController: self)
        self.view = self.loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Funcoes
    @objc public func redirecionarParaTelaDeCriacaoDeContato(_ sender: UIButton) -> Void { // pq esse _ sender
        guard let navigationController = self.navigationController else { return }
        
        let criacaoDeContatoViewController = CriacaoDeContatoViewController()
        
        navigationController.pushViewController(criacaoDeContatoViewController, animated: true)
    }
    
}
