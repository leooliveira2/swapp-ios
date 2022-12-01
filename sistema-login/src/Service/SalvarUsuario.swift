//
//  SalvarUsuario.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

class SalvarUsuario: NSObject {

    public func salvar(_ usuario: Usuario) -> Void {
        UsuarioDao.salvarUsuario(usuario)
    }
}
