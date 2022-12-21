//
//  Nave.swift
//  sistema-login
//
//  Created by Leonardo Leite on 05/12/22.
//

import UIKit

class Nave: Codable {
    
    private var name = ""
    private var model = ""
    private var manufacturer = ""
    private var cost_in_credits = ""
    private var length = ""
    private var passengers = ""
    
    public func getListaComDadosDaNave() -> [String] {
        let caracteristicasDaNave: [String] = [
            "Nome: \(self.name)",
            "Modelo: \(self.model)",
            "Fabricante: \(self.manufacturer)",
            "Custo em créditos: \(self.cost_in_credits)",
            "Comprimento: \(self.length)",
            "Passageiros: \(self.passengers)"
        ]
        
        return caracteristicasDaNave
    }

}
