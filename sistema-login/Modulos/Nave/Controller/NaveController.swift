//
//  NaveController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 05/12/22.
//

import UIKit

class NaveController {
    
    private var requisicoesSWAPI: RequisicoesStarWarsAPI
    
    init(requisicoesSWAPI: RequisicoesStarWarsAPI) {
        self.requisicoesSWAPI = requisicoesSWAPI
    }
    
    public func gerarNave(
        sucesso: @escaping(_ nave: Nave) -> Void,
        fracasso: @escaping() -> Void
    ) -> Void
    {
        requisicoesSWAPI.fazRequisicaoNave(id: gerarIdAleatorio()) { nave in
            guard let naveVindaDaRequisicao = nave else { fracasso(); return }
            
            sucesso(naveVindaDaRequisicao)
            return
        }
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(41))
        return numero
    }
}
