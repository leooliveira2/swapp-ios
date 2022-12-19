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

class SalvarUsuarioSystem: SalvarUsuarioRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic()
    }
    
    public func salvar(_ usuario: Usuario) -> Bool {
        usuariosArmazenamento.salvarUsuario(usuario)
        
        return true
    }
    
}
