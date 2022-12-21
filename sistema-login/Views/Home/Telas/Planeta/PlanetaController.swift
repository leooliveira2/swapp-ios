//
//  PlanetaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PlanetaController {
    
    let animacao: Animacao
    let vC: ExibeTableViewDelegate
    
    init(animacao: Animacao, vC: ExibeTableViewDelegate) {
        self.animacao = animacao
        self.vC = vC
    }

    public func gerarPlaneta(
        sucesso: @escaping(_ planetaVindoDaRequisicao: Planeta) -> Void,
        fracasso: @escaping(_ falhaNaRequisicao: Bool) -> Void) -> Void
    {
        RequisicoesStarWarsAPI(animacao: self.animacao).fazRequisicaoPlaneta(id: gerarIdAleatorio(), sucesso: { (planeta) in
            sucesso(planeta)
        },
        falha: { (falha) in
            fracasso(falha)
        })
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(60))
        return numero
    }
}
