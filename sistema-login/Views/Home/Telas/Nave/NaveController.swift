//
//  NaveController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 05/12/22.
//

import UIKit

class NaveController {
    
    let animacao: Animacao
    let vC: ExibeTableViewDelegate
    
    init(animacao: Animacao, vC: ExibeTableViewDelegate) {
        self.animacao = animacao
        self.vC = vC
    }
    
    public func gerarNave(
        sucesso: @escaping(_ naveVindaDaRequisicao: Nave) -> Void,
        fracasso: @escaping(_ falhaNaRequisicao: Bool) -> Void) -> Void
    {
        RequisicoesStarWarsAPI(animacao: self.animacao).fazRequisicaoNave(id: gerarIdAleatorio(), sucesso: { (nave) in
            sucesso(nave)
        },
        falha: { (falha) in
            fracasso(falha)
        })
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(41))
        return numero
    }
}
