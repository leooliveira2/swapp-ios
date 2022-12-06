//
//  BuscadorDeUsuariosSalvos.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

class BuscadorDeUsuariosSalvos {
    
    public func buscaUsuariosSalvos() -> [Usuario] {
        return UsuariosDadosStatic.getUsuariosSalvos()
    }
}
