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

class RecuperaDadosDoUsuarioSystem: RecuperaDadosDoUsuarioRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic()
    }
    
    public func getNickNameDoUsuario(email: String) -> String? {
        let listaDeUsuarios = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in listaDeUsuarios {
            if usuario.getEmailDoUsuario() == email {
                return usuario.getNickNameDeUsuario()
            }
        }
        
        return nil
    }
    
}
