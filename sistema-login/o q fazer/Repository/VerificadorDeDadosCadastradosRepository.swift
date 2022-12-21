//
//  VerificadorDeDadosJaCadastradosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol VerificadorDeDadosCadastradosRepository {
    
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool
}

class VerificadorDeDadosCadastradosSystem: VerificadorDeDadosCadastradosRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    public func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getNickNameDeUsuario() == nickName {
                return true
            }
        }
        
        return false
    }
    
    public func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                return true
            }
        }
        
        return false
    }
    
}

