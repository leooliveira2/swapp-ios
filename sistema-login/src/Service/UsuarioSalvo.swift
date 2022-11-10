//
//  UsuarioSalvo.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class UsuarioSalvo: NSObject {
    
    static private var usuariosSalvos: [Usuario] = []
    
    public static func salvarUsuario(_ usuario: Usuario) -> Void {
        usuariosSalvos.append(usuario)
    }
    
    public static func getUsuariosSalvos() -> [Usuario] {
        return self.usuariosSalvos
    }
}
