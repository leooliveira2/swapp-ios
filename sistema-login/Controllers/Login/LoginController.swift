//
//  LoginController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class LoginController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeLogin: ValidacaoDeLogin
    
    init(_ controladorDeErros: ControladorDeErros, _ validadorDeLogin: ValidacaoDeLogin) {
        self.controladorDeErros = controladorDeErros
        self.validadorDeLogin = validadorDeLogin
    }
    
    public func fazerLogin(email: String?, senha: String?) -> Bool {
        guard let email,
              let senha else
        {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        let cadastroFoiEncontrado = validadorDeLogin.loginPodeSerRealizado(
            emailDoUsuario: email,
            senhaDoUsuario: senha
        )
        
        return cadastroFoiEncontrado
    }

}
