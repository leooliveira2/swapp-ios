//
//  PersonagensFavoritosController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class PersonagensFavoritosController {
    
    let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func buscaTodosOsPersonagensFavoritosDoUsuario(
        nickNameUsuario: String,
        buscadorDePersonagensFavoritos: BuscadorDePersonagensFavoritosRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> [Personagem]?
    {
        guard let idUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(
            nickName: nickNameUsuario
        ) else {
            return nil
        }
        
        let listaDePersonagensFavoritos = buscadorDePersonagensFavoritos.buscarTodosOsPersonagens(idUsuario: idUsuario)
        
        return listaDePersonagensFavoritos
    }
}
