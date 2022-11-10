//
//  LoginController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class LoginController: NSObject {
    
    private let controladorDeErros: ControladorDeErros
    
    init(_ controladorDeErros: ControladorDeErros) {
        self.controladorDeErros = controladorDeErros
    }
    
    public func fazerLogin(email: String?, senha: String?) -> Bool {
        let validadorLogin = ValidacaoDeLogin(self.controladorDeErros)
        
        let cadastroFoiEncontrado = validadorLogin.loginPodeSerRealizado(
            emailDoUsuario: email,
            senhaDoUsuario: senha
        )
        
        return cadastroFoiEncontrado
    }
    
}
