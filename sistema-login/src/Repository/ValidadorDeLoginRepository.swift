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

class ValidadorDeLoginStaticClass: ValidadorDeLoginRepository {
    
    func validarLogin(email: String, senha: String) -> Bool {
        let listaDeUsuarios = UsuariosDadosStatic.getUsuariosSalvos()
        
        for usuario in listaDeUsuarios {
            if email == usuario.getEmailDoUsuario() &&
                senha == usuario.getSenhaDoUsuario() {
                return true
            }
        }
        
        return false
    }
    
}
