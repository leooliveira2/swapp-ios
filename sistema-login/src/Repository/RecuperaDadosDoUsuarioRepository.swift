//
//  RecuperaDadosDoUsuarioRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 12/12/22.
//

import UIKit

protocol RecuperaDadosDoUsuarioRepository {
    
    func getNickNameDoUsuario(email: String) -> String?
    
}

class RecuperaDadosDoUsuarioStaticClass: RecuperaDadosDoUsuarioRepository {
    
    public func getNickNameDoUsuario(email: String) -> String? {
        let listaDeUsuarios = UsuariosDadosStatic.getUsuariosSalvos()
        
        for usuario in listaDeUsuarios {
            if usuario.getEmailDoUsuario() == email {
                return usuario.getNickNameDeUsuario()
            }
        }
        
        return nil
    }
    
}
