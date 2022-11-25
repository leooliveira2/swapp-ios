//
//  PersonagemController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 25/11/22.
//

import UIKit

class PersonagemController: NSObject {

    public func gerarPersonagem() -> Bool {
        var requisicaoDeuCerto = true
        RequisicoesStarWarsAPI().fazRequisicaoPersonagem(id: gerarIdAleatorio(), sucesso: { (personagem) in
            print(personagem.getNome())
        },
        falha: { (falha) in
            requisicaoDeuCerto = falha
        })
        
        return requisicaoDeuCerto
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(83))
        return numero
    }
}
