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

class VerificadorDeDadosCadastradosStaticClass: VerificadorDeDadosCadastradosRepository {
    
    public func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let usuariosSalvos = UsuariosDadosStatic.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getNickNameDeUsuario() == nickName {
                return true
            }
        }
        
        return false
    }
    
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

