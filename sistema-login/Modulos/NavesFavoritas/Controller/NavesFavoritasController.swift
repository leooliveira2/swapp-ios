//
//  NavesFavoritasController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class NavesFavoritasController {
    
    let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func buscaTodasAsNavesFavoritasDoUsuario(
        nickNameUsuario: String,
        buscadorDeNavesFavoritas: BuscadorDeNavesFavoritasRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> [Nave]?
    {
        guard let idUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(
            nickName: nickNameUsuario
        ) else {
            return nil
        }
        
        let listaDeNavesFavoritas = buscadorDeNavesFavoritas.buscarTodasAsNaves(idUsuario: idUsuario)
        
        return listaDeNavesFavoritas
    }
    
}
