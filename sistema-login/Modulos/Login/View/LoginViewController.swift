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
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usuarioEstaLogado = UserDefaults.standard.bool(forKey: "esta_logado")
        
        if usuarioEstaLogado {
            guard let navigationController = self.navigationController else { return }
            navigationController.pushViewController(HomeTabBarController(), animated: true)
            return
        }
        
        self.view = self.loginView
        
        self.loginView.getBotaoDeEntrar().addTarget(
            self, action: #selector(realizarLogin(_:)),
            for: .touchUpInside
        )
        
        self.loginView.getBotaoDeCadastro().addTarget(
            self, action: #selector(redirecionarParaTelaDeCriacaoDeContato(_:)),
            for: .touchUpInside
        )
        
        self.loginView.getBotaoRecuperarSenha().addTarget(self, action: #selector(redirecionarParaTelaDeRecuperacaoDeSenha(_:)), for: .touchUpInside)
        
        guard let db = DBManager().openDatabase(DBPath: "UsuariosCadastrados.sqlite") else { return }
        
        Crud().exibeTodosOsUsuariosSalvos(instanciaDoBanco: db)

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Acoes
    @objc private func redirecionarParaTelaDeCriacaoDeContato(_ sender: UIButton) -> Void {
        guard let navigationController = self.navigationController else { return }
        
        let criacaoDeContaViewController = CriacaoDeContaViewController()
        
        navigationController.pushViewController(criacaoDeContaViewController, animated: true)
    }
    
    @objc private func redirecionarParaTelaDeRecuperacaoDeSenha(_ sender: UIButton) -> Void {
        guard let navigationController = self.navigationController else { return }
        
        let recuperacaoDeSenhaViewController = RecuperacaoDeSenhaViewController()
        
        navigationController.pushViewController(recuperacaoDeSenhaViewController, animated: true)
    }
    
    @objc private func realizarLogin(_ sender: UIButton) -> Void {
        let alertas = Alerta(viewController: self)
        
        let controladorDeErros = ControladorDeErros()
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "UsuariosCadastrados.sqlite") else {
            alertas.criaAlerta(mensagem: "Erro de conexão! Favor tentar novamente")
            return
        }
        
        let validadorDeLogin = ValidadorDeLoginSQLite(instanciaDoBanco: instanciaDoBanco)
        
        let validadorDeUsuario = ValidacoesDeDadosDoUsuario(controladorDeErros)
        let recuperaDadosDoUsuario = RecuperaDadosDoUsuarioSystem()
        
        let controlador = LoginController(
            controladorDeErros,
            validadorDeLogin,
            validadorDeUsuario,
            recuperaDadosDoUsuario
        )
        
        let loginPodeSerRealizado = controlador.fazerLogin(
            email: self.loginView.getEmailDoUsuarioTextField().text,
            senha: self.loginView.getSenhaDoUsuarioTextField().text
        )
        
        if !loginPodeSerRealizado {
            let listaDeErros = controladorDeErros.getErros()
            if listaDeErros.count > 0 {
                alertas.criaAlerta(mensagem: listaDeErros[0].rawValue)
                return
            }
            
        }
       
        guard let navigationController = self.navigationController else {
            alertas.criaAlerta(mensagem: "Tente novamente!")
            return
        }
        
        let homeTabBarController = HomeTabBarController()
        navigationController.pushViewController(homeTabBarController, animated: true)
    }

}
