//
//  PlanetasFavoritosController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class PlanetasFavoritosController {

    let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func buscaTodosOsPlanetasFavoritosDoUsuario(
        nickNameUsuario: String,
        buscadorDePlanetasFavoritos: BuscadorDePlanetasFavoritosRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> [Planeta]?
    {
        guard let idUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(
            nickName: nickNameUsuario
        ) else {
            return nil
        }
        
        let listaDePlanetasFavoritos = buscadorDePlanetasFavoritos.buscarTodosOsPlanetas(idUsuario: idUsuario)
        
        return listaDePlanetasFavoritos
    }

}
