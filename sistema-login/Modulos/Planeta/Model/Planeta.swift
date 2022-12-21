//
//  Planeta.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class Planeta: Codable {
    
    private var name: String = ""
    private var diameter: String = ""
    private var climate: String = ""
    private var gravity: String = ""
    private var terrain: String = ""
    private var population: String = ""
    
    public func getListaComDadosDoPlaneta() -> [String] {
        let caracteristicasDoPlaneta: [String] = [
            "Nome: \(self.name)",
            "Diâmetro: \(self.diameter)",
            "Clima: \(self.climate)",
            "Gravidade: \(self.gravity)",
            "Terreno: \(self.terrain)",
            "População: \(self.population)"
        ]
        
        return caracteristicasDoPlaneta
    }

}
