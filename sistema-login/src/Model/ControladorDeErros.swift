//
//  ControladorDeErros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class ControladorDeErros {
    
    private var erros: Array<Erros> = []
    
    public func adicionarErro(erro: Erros) -> Void {
        self.erros.append(erro)
    }
    
    public func getErros() -> Array<Erros> {
        return self.erros
    }
}
