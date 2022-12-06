//
//  VerificadorDeEmailsJaCadastradosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol VerificadorDeEmailsJaCadastradosRepository {
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool
}

class VerificadorDeEmailsJaCadastradosStaticClass: VerificadorDeEmailsJaCadastradosRepository {
   
    public func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        let usuariosSalvos = UsuariosDadosStatic.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                return true
            }
        }
        
        return false
    }
    
}
