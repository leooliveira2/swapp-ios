//
//  LoginViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var loginView: LoginView = {
        let view = LoginView()
        return view
    }()
    
    // MARK: - View life cycle - pesquisar sobre
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.loginView
        self.loginView.getBotaoDeCadastro().addTarget(self, action: #selector(redirecionarParaTelaDeCriacaoDeContato(_:)), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Funcoes
    @objc private func redirecionarParaTelaDeCriacaoDeContato(_ sender: UIButton) -> Void {
        guard let navigationController = self.navigationController else { return }
        
        let criacaoDeContaViewController = CriacaoDeContaViewController()
        
        navigationController.pushViewController(criacaoDeContaViewController, animated: true)
    }
    
}
