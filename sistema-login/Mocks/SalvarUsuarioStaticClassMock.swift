//
//  SalvarUsuarioStaticClassMock.swift
//  sistema-login
//
//  Created by Leonardo Leite on 14/12/22.
//

import UIKit

class SalvarUsuarioStaticClassMock: SalvarUsuarioRepository {
    
    var retornoDaFuncaoSalvar: Bool!
    var quantasVezesAFuncaoSalvarFoiChamada: Int = 0
    
    func salvar(_ usuario: Usuario) -> Bool {
        self.quantasVezesAFuncaoSalvarFoiChamada += 1
        return retornoDaFuncaoSalvar
    }
    
}
