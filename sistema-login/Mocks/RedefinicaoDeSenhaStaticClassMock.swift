//
//  RedefinicaoDeSenhaStaticClassMock.swift
//  sistema-login
//
//  Created by Leonardo Leite on 14/12/22.
//

import UIKit

class RedefinicaoDeSenhaStaticClassMock: RedefinicaoDeSenhaRepository {
    
    var retornoDaFuncaoRedefinirSenha: Bool!
    var quantasVezesAFuncaoRedefinirSenhaFoIChamada: Int = 0
    
    func redefinirSenha(email: String, senha: String) -> Bool {
        self.quantasVezesAFuncaoRedefinirSenhaFoIChamada += 1
        return self.retornoDaFuncaoRedefinirSenha
    }
    
}
