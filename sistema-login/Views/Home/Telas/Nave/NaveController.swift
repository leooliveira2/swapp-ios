//
//  NaveController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 05/12/22.
//

import UIKit

class NaveController: NSObject {
    
    public func gerarNave(
        sucesso: @escaping(_ naveVindaDaRequisicao: Nave) -> Void,
        fracasso: @escaping(_ falhaNaRequisicao: Bool) -> Void) -> Void
    {
        RequisicoesStarWarsAPI().fazRequisicaoNave(id: gerarIdAleatorio(), sucesso: { (nave) in
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
