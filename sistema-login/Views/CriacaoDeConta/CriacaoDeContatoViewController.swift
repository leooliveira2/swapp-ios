//
//  CriacaoDeContatoViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class CriacaoDeContatoViewController: UIViewController {
    
    // MARK: - Atributos
    private var criacaoDeContatoScreen: CriacaoDeContatoScreen?
    
    override func loadView() {
        self.criacaoDeContatoScreen = CriacaoDeContatoScreen(frame: .zero, criacaoDeContatoViewController: self)
        self.view = self.criacaoDeContatoScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        // self.navigationController?.navigationBar.backItem?.title = "Voltar" / esse ou o de baixo
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    public func criarConta(
        nickNameDoUsuario: String?,
        nomeCompletoDoUsuario: String?,
        emailDoUsuario: String?,
        senhaDoUsuario: String?,
        repeticaoDeSenhaDoUsuario: String?
    ) -> Void {
        
        let controladorDeErros = ControladorDeErros()
        let validadorUsuario = ValidacaoDeUsuarioParaCadastro(controladorDeErros: controladorDeErros)
        
        let usuarioPodeSerCadastrado = validadorUsuario.usuarioPodeSerCadastrado(
            nickNameDoUsuario: nickNameDoUsuario,
            nomeCompletoDoUsuario: nomeCompletoDoUsuario,
            emailDoUsuario: emailDoUsuario,
            senhaDoUsuario: senhaDoUsuario,
            repeticaoDeSenhaDoUsuario: repeticaoDeSenhaDoUsuario
        )
        
        if usuarioPodeSerCadastrado {
            guard let usuario = self.criaUsuario(
                nickNameDoUsuario,
                nomeCompletoDoUsuario,
                emailDoUsuario,
                senhaDoUsuario,
                repeticaoDeSenhaDoUsuario
            ) else { return }
            
            guard let navigationController = self.navigationController else { return }
            navigationController.popViewController(animated: true)
        }
        
        if controladorDeErros.getErros().count > 0 {
            let controladorDeAlertas = Alerta(viewController: self)
            
            let mensagem = controladorDeErros.getErros()[0]
            
            controladorDeAlertas.criaAlerta(mensagem: mensagem)
        }
    }
    
    private func criaUsuario(
        _ nickNameDoUsuario: String?,
        _ nomeCompletoDoUsuario: String?,
        _ emailDoUsuario: String?,
        _ senhaDoUsuario: String?,
        _ repeticaoDeSenhaDoUsuario: String?
    ) -> Usuario? {
        guard let nickName = nickNameDoUsuario,
              let nomeCompleto = nomeCompletoDoUsuario,
              let email = emailDoUsuario,
              let senha = senhaDoUsuario,
              let repeticaoDeSenha = repeticaoDeSenhaDoUsuario else { return nil }
        
        let usuario = Usuario(
            nickName: nickName,
            nomeCompleto: nomeCompleto,
            email: email,
            senha: senha,
            repeticaoDeSenha: repeticaoDeSenha
        )
        
        return usuario
    }

}
