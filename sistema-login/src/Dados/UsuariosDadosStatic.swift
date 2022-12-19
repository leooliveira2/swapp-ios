//
//  UsuarioDao.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

// Monostate

class UsuariosDadosStatic {
    
    private static var usuariosSalvos: [Usuario] = []

    public func salvarUsuario(_ usuario: Usuario) -> Void {
        UsuariosDadosStatic.usuariosSalvos.append(usuario)
    }

    public func getUsuariosSalvos() -> [Usuario] {
        return UsuariosDadosStatic.usuariosSalvos
    }
    
}
