//
//  ValidadorDeLoginRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol ValidadorDeLoginRepository {
    
    func validarLogin(email: String, senha: String) -> Bool
    
}

class ValidadorDeLoginSystem: ValidadorDeLoginRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    func validarLogin(email: String, senha: String) -> Bool {
        let listaDeUsuarios = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in listaDeUsuarios {
            if email == usuario.getEmailDoUsuario() &&
                senha == usuario.getSenhaDoUsuario() {
                return true
            }
        }
        
        return false
    }
    
}
