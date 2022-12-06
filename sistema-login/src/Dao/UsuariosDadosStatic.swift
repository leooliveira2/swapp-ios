//
//  UsuarioDao.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class UsuariosDadosStatic {
    
    static private var usuariosSalvos: [Usuario] = [Usuario(nickName: "Leo12", nomeCompleto: "Leonardo", email: "Email@email.com", senha: "123123123", repeticaoDeSenha: "123123123")]
    
    public static func salvarUsuario(_ usuario: Usuario) -> Void {
        usuariosSalvos.append(usuario)
    }
    
    public static func getUsuariosSalvos() -> [Usuario] {
        return self.usuariosSalvos
    }

}
