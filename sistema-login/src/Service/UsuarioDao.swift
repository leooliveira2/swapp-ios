//
//  UsuarioDao.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class UsuarioDao: NSObject {
    
    static private var usuariosSalvos: [Usuario] = []
    
    public static func salvarUsuario(_ usuario: Usuario) -> Void {
        usuariosSalvos.append(usuario)
    }
    
    public static func getUsuariosSalvos() -> [Usuario] {
        return self.usuariosSalvos
    }
    
    public static func editarSenha(email: String, senha: String) {
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                usuario.alterarSenha(senha)
            }
        }
    }
    
    public static func nickNameDeUsuarioJaEstaCadastrado(nicknameDeUsuario: String) -> Bool {
        for usuario in usuariosSalvos {
            if usuario.getNickNameDeUsuario() == nicknameDeUsuario {
                return true
            }
        }
        
        return false
    }
    
    public static func emailJaEstaCadastrado(emailDeUsuario: String) -> Bool {
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == emailDeUsuario {
                return true
            }
        }
        
        return false
    }
}
