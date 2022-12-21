//
//  PersonagemController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 25/11/22.
//

import UIKit

class PersonagemController {
    
    private var requisicoesSWAPI: RequisicoesStarWarsAPI
    
    init(requisicoesSWAPI: RequisicoesStarWarsAPI) {
        self.requisicoesSWAPI = requisicoesSWAPI
    }
    
    public func gerarPersonagem(
        sucesso: @escaping(_ personagem: Personagem) -> Void,
        fracasso: @escaping() -> Void
    ) -> Void
    {
        requisicoesSWAPI.fazRequisicaoPersonagem(id: gerarIdAleatorio()) { personagem in
            guard let personagemVindoDaRequisicao = personagem else { fracasso(); return }
            
            sucesso(personagemVindoDaRequisicao)
            return
        }
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(83))
        return numero
    }
}
