//
//  LoginController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class LoginController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeLogin: ValidadorDeLoginRepository
    private let validadorDeUsuario: ValidacoesDeDadosDoUsuario
    
    init(
        _ controladorDeErros: ControladorDeErros,
        _ validadorDeLogin: ValidadorDeLoginRepository,
        _ validadorDeUsuario: ValidacoesDeDadosDoUsuario
    )
    {
        self.controladorDeErros = controladorDeErros
        self.validadorDeLogin = validadorDeLogin
        self.validadorDeUsuario = validadorDeUsuario
    }
    
    public func fazerLogin(email: String?, senha: String?) -> Bool {
        guard let email,
              let senha else
        {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        let loginPodeSerRealizado = self.verificaSeLoginPodeSerRealizado(email, senha)
        
        return loginPodeSerRealizado
    }
    
    private func verificaSeLoginPodeSerRealizado(_ email: String, _ senha: String) -> Bool {
        let algumCampoDosFormulariosEstaVazio = (
            self.validadorDeUsuario.verificaSeEmailDoUsuarioEstaVazio(email) ||
            self.validadorDeUsuario.verificaSeSenhaDoUsuarioEstaVazia(senha)
        )
        
        let loginNaoPodeSerRealizado = !self.validadorDeUsuario.verificaSeLoginPodeSerRealizado(email, senha, self.validadorDeLogin)
        
        if algumCampoDosFormulariosEstaVazio || loginNaoPodeSerRealizado {
            return false
        }
        
        return true
    }

}

