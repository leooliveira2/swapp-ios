//
//  PersonagemController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 25/11/22.
//

import UIKit

class PersonagemController: NSObject {

    public func gerarPersonagem(
        sucesso: @escaping(_ personagemVindoDaRequisicao: Personagem) -> Void,
        fracasso: @escaping(_ falhaNaRequisicao: Bool) -> Void) -> Void
    {
        RequisicoesStarWarsAPI().fazRequisicaoPersonagem(id: gerarIdAleatorio(), sucesso: { (personagem) in
            sucesso(personagem)
        },
        falha: { (falha) in
            fracasso(falha)
        })
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(83))
        return numero
    }
}
