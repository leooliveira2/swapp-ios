//
//  RedefinicaoDeSenha.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

class RedefinicaoDeSenha: NSObject {

    public func redefinirSenha(email: String, senha: String) -> Void {
        UsuarioDao.editarSenha(email: email, senha: senha)
    }
}
