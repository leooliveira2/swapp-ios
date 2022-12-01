//
//  BuscadorDeUsuariosSalvos.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

class BuscadorDeUsuariosSalvos: NSObject {
    
    public func buscaUsuariosSalvos() -> [Usuario] {
        return UsuarioDao.getUsuariosSalvos()
    }
}
