//
//  PlanetaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PlanetaController {
    
    private var requisicoesSWAPI: RequisicoesStarWarsAPI
    
    init(requisicoesSWAPI: RequisicoesStarWarsAPI) {
        self.requisicoesSWAPI = requisicoesSWAPI
    }
    
    public func gerarPlaneta(
        sucesso: @escaping(_ planeta: Planeta) -> Void,
        fracasso: @escaping() -> Void
    ) -> Void
    {
        requisicoesSWAPI.fazRequisicaoPlaneta(id: gerarIdAleatorio()) { planeta in
            guard let planetaVindoDaRequisicao = planeta else { fracasso(); return }
            
            sucesso(planetaVindoDaRequisicao)
            return
        }
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(60))
        return numero
    }
}
