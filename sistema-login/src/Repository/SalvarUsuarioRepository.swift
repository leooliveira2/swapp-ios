//
//  SalvarUsuario.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

protocol SalvarUsuarioRepository {

    func salvar(_ usuario: Usuario) -> Bool
    
}

class SalvarUsuarioStaticClass: SalvarUsuarioRepository {
    
    public func salvar(_ usuario: Usuario) -> Bool {
        UsuariosDadosStatic.salvarUsuario(usuario)
        
        return true
    }
    
}
