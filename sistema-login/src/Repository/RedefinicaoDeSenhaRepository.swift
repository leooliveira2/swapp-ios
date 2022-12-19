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

class RedefinicaoDeSenhaSystem: RedefinicaoDeSenhaRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic()
    }
    
    public func redefinirSenha(email: String, senha: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                usuario.alterarSenha(senha)

                return true
            }
        }
        
        return false
    }
    
}
