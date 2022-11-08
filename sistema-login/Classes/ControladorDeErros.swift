//
//  ControladorDeErros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class ControladorDeErros: NSObject {
    
    private var erros: Array<String> = []
    
    public func adicionarErro(erro: Erros) -> Void {
        self.erros.append(erro.rawValue)
    }
    
    public func getErros() -> Array<String> {
        return self.erros
    }
}
