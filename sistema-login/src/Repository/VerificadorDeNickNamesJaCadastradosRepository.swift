//
//  VerificadorDeDadosJaCadastradosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol VerificadorDeNickNamesJaCadastradosRepository {
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool
}

class VerificadorDeNickNamesJaCadastradosStaticClass: VerificadorDeNickNamesJaCadastradosRepository {
    
    public func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let usuariosSalvos = UsuariosDadosStatic.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getNickNameDeUsuario() == nickName {
                return true
            }
        }
        
        return false
    }
    
}

