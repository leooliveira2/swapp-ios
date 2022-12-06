//
//  RedefinicaoDeSenha.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

protocol RedefinicaoDeSenhaRepository {

    func redefinirSenha(email: String, senha: String) -> Bool
       
}

class RedefinicaoDeSenhaStaticClass: RedefinicaoDeSenhaRepository {
    
    public func redefinirSenha(email: String, senha: String) -> Bool {
        let usuariosSalvos = UsuariosDadosStatic.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                usuario.alterarSenha(senha)
                
                return true
            }
        }
        
        return false
    }
    
}
